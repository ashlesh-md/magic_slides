import 'dart:io';

import 'package:magic_slides/feature/home/domain/model/generated_presentation_model.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:statemachine/statemachine.dart';

sealed class HomeEvent extends Event {
  HomeEvent(super.eventName);
}

class EditSettingsClicked extends HomeEvent {
  EditSettingsClicked() : super("");
}

class LogoutClicked extends HomeEvent {
  LogoutClicked() : super("");
}

class LogoutConfirmed extends HomeEvent {
  LogoutConfirmed() : super("");
}

class LogoutSuccess extends HomeEvent {
  LogoutSuccess() : super("");
}

class LogoutFailed extends HomeEvent {
  LogoutFailed() : super("");
}

class SettingsUpdated extends HomeEvent {
  PresentationSettingsModel settings;
  SettingsUpdated(this.settings) : super("");
}

class GenerateClicked extends HomeEvent {
  GenerateClicked() : super("");
}

class GenerationStated extends HomeEvent {
  GenerationStated() : super("");
}

class GenerationFinished extends HomeEvent {
  GeneratedPresentationModel generatedPresentationModel;
  GenerationFinished(this.generatedPresentationModel) : super("");
}

class GenerationFailed extends HomeEvent {
  String reason;
  GenerationFailed(this.reason) : super("");
}

class RefreshClicked extends HomeEvent {
  RefreshClicked() : super("");
}

class RegenerateClicked extends HomeEvent {
  RegenerateClicked() : super("");
}

class DownloadFileClicked extends HomeEvent {
  File file;
  DownloadFileClicked(this.file) : super("");
}
