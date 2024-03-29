import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:two_meters/src/domain/auth/i_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  AuthBloc(this._authRepository);

  @override
  AuthState get initialState => AuthState.initial();
  

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(
      getAuthenticatedUser: (e) async* {
        final userOption = await _authRepository.getSignedInUser();
        yield userOption.fold(() => const AuthState.unauthenticated(), (a) => const AuthState.authenticated());
      },

      signOut: (e) async* {
        await _authRepository.signOut();
        yield const AuthState.unauthenticated();
      }
    );
  }
}
