import 'package:magic_slides/core/injection/injection.dart';
import 'package:magic_slides/feature/authentication/authentication_injection.dart';
import 'package:magic_slides/feature/home/data/repository/presentation_repository_impl.dart';
import 'package:magic_slides/feature/home/domain/repository/presentation_repository.dart';
import 'package:magic_slides/feature/home/domain/usecase/generate_presentation_usecase.dart';
import 'package:magic_slides/feature/home/domain/usecase/logout_usecase.dart';

class HomeInjection {
  void inject() {
    mainModule.registerFactory<PresentationRepository>(
      () => PresentationRepositoryImpl(apiService: mainModule()),
    );
    mainModule.registerFactory<LogoutUsecase>(
      () => LogoutUsecase(authenticationRepository: authenticationModule()),
    );
    mainModule.registerFactory<GeneratePresentationUsecase>(
      () => GeneratePresentationUsecase(
        fileService: mainModule(),
        presentationRepository: mainModule(),
      ),
    );
  }
}
