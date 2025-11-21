import 'package:get_it/get_it.dart';
import 'package:magic_slides/core/injection/injection.dart';
import 'package:magic_slides/feature/authentication/authentication_injection.dart';
import 'package:magic_slides/feature/authentication/domain/repository/authentication_repository.dart';

class LogoutUsecase {
  final AuthenticationRepository _authenticationRepository;

  LogoutUsecase({required AuthenticationRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository;

  Future<bool> execute() async {
    try {
      await _authenticationRepository.signOut();

      await mainModule.reset();
      await authenticationModule.reset();

      mainModule = GetIt.asNewInstance();
      authenticationModule = GetIt.asNewInstance();
      Injection().inject();

      return true;
    } catch (_) {
      return false;
    }
  }
}
