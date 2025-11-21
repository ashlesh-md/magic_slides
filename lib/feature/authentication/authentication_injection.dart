import 'package:get_it/get_it.dart';
import 'package:magic_slides/feature/authentication/data/repository/authentication_repository_impl.dart';
import 'package:magic_slides/feature/authentication/domain/repository/authentication_repository.dart';

GetIt authenticationModule = GetIt.asNewInstance();

class AuthenticationInjection {
  void inject() {
    authenticationModule.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(),
    );
  }
}
