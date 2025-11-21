// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:statemachine/statemachine.dart';

import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';

sealed class HomeAsyncSideEffect extends AsyncSideEffect {}

class Logout extends HomeAsyncSideEffect {}

class GeneratePresentation extends HomeAsyncSideEffect {
  String topic;
  PresentationSettingsModel settings;
  GeneratePresentation({required this.topic, required this.settings});
}

class UpdateAccessId extends HomeAsyncSideEffect {
  String accessId;
  UpdateAccessId(this.accessId);
}

sealed class HomeUISideEffect extends UISideEffect {}

class ShowPresentationSettingsBottomSheet extends HomeUISideEffect {
  PresentationSettingsModel settingsModel;
  ShowPresentationSettingsBottomSheet(this.settingsModel);
}

class ShowLogoutConfirmationPopup extends HomeUISideEffect {
  ShowLogoutConfirmationPopup();
}

class ShowSnackbar extends HomeUISideEffect {
  String message;
  ShowSnackbar(this.message);
}

class ShowRefreshPopup extends HomeUISideEffect {
  ShowRefreshPopup();
}

class ShareFile extends HomeUISideEffect {
  File file;
  ShareFile(this.file);
}

class ShowAssetIdUpdateBottomSheet extends HomeUISideEffect {
  ShowAssetIdUpdateBottomSheet();
}
