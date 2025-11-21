import 'package:flutter/material.dart';
import 'package:magic_slides/feature/home/domain/model/generated_presentation_model.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:statemachine/statemachine.dart';

class HomeState extends BaseState {
  final TextEditingController _topicController = TextEditingController();
  TextEditingController get topicController => _topicController;

  PresentationSettingsModel? _presentationSettingsModel;
  PresentationSettingsModel get presentationSettingsModel =>
      _presentationSettingsModel ?? PresentationSettingsModel();

  GeneratedPresentationModel? _generatedPresentationModel;
  GeneratedPresentationModel? get generatedPresentationModel =>
      _generatedPresentationModel;

  final _topicFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get topicFormKey => _topicFormKey;

  bool? _isGenerating;
  bool get isGenerating => _isGenerating ?? false;

  void updatePresentationSettingsModel(PresentationSettingsModel? model) {
    _presentationSettingsModel = model;
  }

  void updateGenerationStatus(bool value) {
    _isGenerating = value;
  }

  void updateGeneratedPresentationModel(GeneratedPresentationModel? model) {
    _generatedPresentationModel = model;
  }

  void reset() {
    updateGeneratedPresentationModel(null);
    updateGenerationStatus(false);
    updatePresentationSettingsModel(null);
    _topicController.clear();
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

  @override
  void addListener(VoidCallback listener) {
    _topicController.addListener(listener);
    super.addListener(listener);
  }
}
