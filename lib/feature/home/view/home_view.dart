import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:magic_slides/core/injection/injection.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:magic_slides/feature/home/view/widgets/ask_asset_id_bottom_sheet.dart';
import 'package:magic_slides/feature/home/view/widgets/presentations_settings_bottom_sheet.dart';
import 'package:magic_slides/feature/home/view/statemachine/analytics/home_analytics_handler.dart';
import 'package:magic_slides/feature/home/view/statemachine/side_effect/home_async_side_effect_handler.dart';
import 'package:magic_slides/feature/home/view/statemachine/event/home_event.dart';
import 'package:magic_slides/feature/home/view/statemachine/event/home_event_handler.dart';
import 'package:magic_slides/feature/home/view/statemachine/side_effect/home_side_effect.dart';
import 'package:magic_slides/feature/home/view/statemachine/home_state.dart';
import 'package:magic_slides/feature/home/view/widgets/settings_summary_view.dart';
import 'package:magic_slides/utils/app_utils.dart';
import 'package:magic_slides/utils/widgets/app_text_field.dart';
import 'package:magic_slides/utils/widgets/custom_alert_view.dart';
import 'package:statemachine/statemachine.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class HomeView
    extends
        StateMachineWidget<
          HomeEvent,
          HomeState,
          HomeAsyncSideEffect,
          HomeUISideEffect
        > {
  const HomeView({super.key});

  @override
  AppBar? getAppBar(HomeState state, DispatchEvent<HomeEvent> dispatchEvent) {
    return AppBar(
      title: Text('Magic Slides'),
      actions: [
        if ((state.generatedPresentationModel != null))
          IconButton(
            iconSize: 20,
            onPressed: () => dispatchEvent(RefreshClicked()),
            icon: Icon(Icons.refresh),
          ),
        IconButton(
          iconSize: 20,
          onPressed: () => dispatchEvent(AssetClicked()),
          icon: Icon(Icons.pinch),
        ),
        IconButton(
          iconSize: 20,
          onPressed: () => dispatchEvent(LogoutClicked()),
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Widget buildLayout(HomeState state, DispatchEvent<HomeEvent> dispatchEvent) {
    if (state.generatedPresentationModel != null) {
      return _getPdfPreview(state, dispatchEvent);
    }
    if (state.isGenerating) {
      return Center(child: LottieBuilder.asset('assets/lotties/loading.zip'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Form(
          key: state.topicFormKey,
          child: Column(
            children: [
              const SizedBox(height: 16),
              AppTextField(
                controller: state.topicController,
                hint: 'Enter your topic',
                autofocus: true,
                onTapOutside: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              SettingsSummaryView(
                model: state.presentationSettingsModel,
                onEditClicked: () {
                  dispatchEvent(EditSettingsClicked());
                },
              ),
              FilledButton(
                onPressed: () {
                  final status = state.topicFormKey.currentState?.validate();
                  if (status ?? false) {
                    dispatchEvent(GenerateClicked());
                  }
                },
                child: Text('Generate Presentation'),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPdfPreview(
    HomeState state,
    DispatchEvent<HomeEvent> dispatchEvent,
  ) {
    return Column(
      children: [
        Expanded(
          child: PDFView(
            filePath: state.generatedPresentationModel!.pdfFile.path,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: () {
                  dispatchEvent(
                    DownloadFileClicked(
                      state.generatedPresentationModel!.pdfFile,
                    ),
                  );
                },
                child: Text('Download Pdf'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  dispatchEvent(
                    DownloadFileClicked(
                      state.generatedPresentationModel!.pptFile,
                    ),
                  );
                },
                child: Text('Download Excel'),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  }

  @override
  Future<void> handleUISideEffect(
    BuildContext context,
    HomeUISideEffect sideEffect,
    DispatchEvent<HomeEvent> dispatchEvent,
  ) async {
    switch (sideEffect) {
      case ShowPresentationSettingsBottomSheet _:
        {
          final updatedModel =
              await showModalBottomSheet<PresentationSettingsModel>(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return PresentationSettingsBottomSheet(
                    model: sideEffect.settingsModel,
                  );
                },
              );

          if (updatedModel != null) {
            dispatchEvent(SettingsUpdated(updatedModel));
          }
        }
      case ShowLogoutConfirmationPopup _:
        {
          showDialog(
            context: context,
            builder: (context) => CustomAlertView(
              title: 'Do yoy want to logout?',
              confirmText: 'Yes,Logout',
              confirmAction: () => dispatchEvent(LogoutConfirmed()),
              cancelText: 'Cancel',
              cancelAction: () {
                context.pop();
              },
            ),
          );
        }
      case ShowSnackbar _:
        {
          ScaffoldMessenger.of(context).showSnackBar(
            AppUtils.buildAppSnackBar(context, sideEffect.message),
          );
        }
      case ShowRefreshPopup _:
        {
          showDialog(
            context: context,
            builder: (context) => CustomAlertView(
              title: 'Do you want to regenerate?',
              content: 'The current generation will not be stored.',
              confirmText: 'Yes, regenerate',
              confirmAction: () {
                context.pop();
                dispatchEvent(RegenerateClicked());
              },
              cancelText: 'Cancel',
              cancelAction: () {
                context.pop();
              },
            ),
          );
        }
      case ShareFile _:
        {
          await AppUtils.shareFile(files: [sideEffect.file]);
        }
      case ShowAssetIdUpdateBottomSheet _:
        {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return AskAssetIdBottomSheet(onSubmit: (assetId) => dispatchEvent(UpdateAssetIdClicked(assetId)));
            },
          );
        }
    }
  }

  @override
  StateMachine<HomeEvent, HomeState, HomeAsyncSideEffect, HomeUISideEffect>
  injectStateMachine() {
    return StateMachineImpl(
      HomeState(),
      HomeEventHandler(),
      HomeAsyncSideEffectHandler(
        logoutUsecase: mainModule(),
        generatePresentationUsecase: mainModule(),
        presentationRepository: mainModule(),
      ),
      HomeAnalyticsHandler(),
    );
  }
}
