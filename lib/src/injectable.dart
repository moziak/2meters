import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:two_meters/src/injectable.iconfig.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection(String env){
  $initGetIt(getIt, environment: env);
}