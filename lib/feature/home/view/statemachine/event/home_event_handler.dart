import 'package:magic_slides/feature/home/view/statemachine/event/home_event.dart';
import 'package:magic_slides/feature/home/view/statemachine/home_state.dart';
import 'package:magic_slides/feature/home/view/statemachine/side_effect/home_side_effect.dart';
import 'package:statemachine/statemachine.dart';

class HomeEventHandler
    extends
        EventHandler<
          HomeEvent,
          HomeState,
          HomeAsyncSideEffect,
          HomeUISideEffect
        > {
  @override
  Next<HomeState?, HomeAsyncSideEffect?, HomeUISideEffect?> handleEvent(
    HomeEvent event,
    HomeState state,
  ) {
    switch (event) {
      case EditSettingsClicked _:
        {
          return Next(
            uiSideEffect: ShowPresentationSettingsBottomSheet(
              state.presentationSettingsModel,
            ),
          );
        }
      case LogoutClicked _:
        {
          return Next(uiSideEffect: ShowLogoutConfirmationPopup());
        }
      case LogoutConfirmed _:
        {
          return Next(asyncSideEffect: Logout());
        }
      case LogoutSuccess _:
        {
          return Next(uiSideEffect: ShowSnackbar('Logged out'));
        }
      case LogoutFailed _:
        {
          return Next(uiSideEffect: ShowSnackbar('Failed to logout'));
        }
      case SettingsUpdated _:
        {
          return Next(
            state: state..updatePresentationSettingsModel(event.settings),
          );
        }
      case GenerateClicked _:
        {
          return Next(
            asyncSideEffect: GeneratePresentation(
              topic: state.topicController.text.trim(),
              settings: state.presentationSettingsModel,
            ),
          );
        }
      case GenerationStated _:
        {
          return Next(state: state..updateGenerationStatus(true));
        }
      case GenerationFinished _:
        {
          return Next(
            state: state
              ..updateGenerationStatus(false)
              ..updateGeneratedPresentationModel(
                event.generatedPresentationModel,
              ),
          );
        }
      case GenerationFailed _:
        {
          return Next(
            state: state
              ..updateGenerationStatus(false),
            uiSideEffect: ShowSnackbar(event.reason));
        }
      case RefreshClicked _:
        {
          return Next(uiSideEffect: ShowRefreshPopup());
        }
      case RegenerateClicked _:
        {
          return Next(state: state..reset());
        }
      case DownloadFileClicked _:
      {
        return Next(uiSideEffect: ShareFile(event.file));
      }
    }
  }
}
