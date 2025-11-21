import 'package:magic_slides/core/exceptions/api_exception.dart';
import 'package:magic_slides/feature/home/domain/repository/presentation_repository.dart';
import 'package:magic_slides/feature/home/domain/usecase/generate_presentation_usecase.dart';
import 'package:magic_slides/feature/home/domain/usecase/logout_usecase.dart';
import 'package:magic_slides/feature/home/view/statemachine/event/home_event.dart';
import 'package:magic_slides/feature/home/view/statemachine/side_effect/home_side_effect.dart';
import 'package:statemachine/statemachine.dart';

class HomeAsyncSideEffectHandler
    extends AsyncSideEffectHandler<HomeEvent, HomeAsyncSideEffect> {
  final LogoutUsecase _logoutUsecase;
  final GeneratePresentationUsecase _generatePresentationUsecase;
  final PresentationRepository _presentationRepository;

  HomeAsyncSideEffectHandler({
    required LogoutUsecase logoutUsecase,
    required GeneratePresentationUsecase generatePresentationUsecase,
    required PresentationRepository presentationRepository,
  }) : _logoutUsecase = logoutUsecase,
       _generatePresentationUsecase = generatePresentationUsecase,
       _presentationRepository = presentationRepository;

  @override
  Future<void> handleSideEffect(
    HomeAsyncSideEffect sideEffect,
    DispatchEvent<HomeEvent> dispatchEvent,
  ) async {
    switch (sideEffect) {
      case Logout _:
        {
          final status = await _logoutUsecase.execute();
          if (status) {
            dispatchEvent(LogoutSuccess());
          } else {
            dispatchEvent(LogoutFailed());
          }
        }
      case GeneratePresentation _:
        {
          dispatchEvent(GenerationStated());
          try {
            final generatedPresentationModel =
                await _generatePresentationUsecase.execute(
                  topic: sideEffect.topic,
                  settings: sideEffect.settings,
                );
            dispatchEvent(GenerationFinished(generatedPresentationModel));
          } on ApiException catch (exception) {
            dispatchEvent(GenerationFailed(exception.message));
          }
        }
      case UpdateAccessId _:
        {
          await _presentationRepository.updateAccessId(sideEffect.accessId);
          dispatchEvent(AccessIdUpdated());
        }
    }
  }

  @override
  void dispose() {}
}
