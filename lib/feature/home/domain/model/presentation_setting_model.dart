import 'package:magic_slides/feature/home/domain/model/presentation_target.dart';
import 'package:magic_slides/feature/home/domain/model/template_type.dart';
import 'package:magic_slides/feature/home/domain/model/water_mark_position.dart';

class PresentationSettingsModel {
  int slideCount;
  String language;
  String model;
  String template;

  TemplateType templateType;

  bool aiImages;
  bool imageEachSlide;
  bool googleImages;
  bool googleText;

  double wmWidth;
  double wmHeight;
  String wmBrandURL;

  PresentationTarget presentationFor;
  WatermarkPosition wmPosition;

  PresentationSettingsModel({
    this.slideCount = 10,
    this.language = 'en',
    this.model = 'gpt-4',
    this.template = 'bullet-point1',
    this.templateType = TemplateType.defaultType,
    this.presentationFor = PresentationTarget.student,
    this.aiImages = false,
    this.imageEachSlide = true,
    this.googleImages = false,
    this.googleText = false,
    this.wmWidth = 100,
    this.wmHeight = 40,
    this.wmBrandURL = '',
    this.wmPosition = WatermarkPosition.bottomRight,
  });

  PresentationSettingsModel copyWith({
    int? slideCount,
    String? language,
    String? model,
    String? template,
    TemplateType? templateType,
    PresentationTarget? presentationFor,
    bool? aiImages,
    bool? imageEachSlide,
    bool? googleImages,
    bool? googleText,
    double? wmWidth,
    double? wmHeight,
    String? wmBrandURL,
    WatermarkPosition? wmPosition,
  }) {
    return PresentationSettingsModel(
      slideCount: slideCount ?? this.slideCount,
      language: language ?? this.language,
      model: model ?? this.model,
      template: template ?? this.template,
      templateType: templateType ?? this.templateType,
      presentationFor: presentationFor ?? this.presentationFor,
      aiImages: aiImages ?? this.aiImages,
      imageEachSlide: imageEachSlide ?? this.imageEachSlide,
      googleImages: googleImages ?? this.googleImages,
      googleText: googleText ?? this.googleText,
      wmWidth: wmWidth ?? this.wmWidth,
      wmHeight: wmHeight ?? this.wmHeight,
      wmBrandURL: wmBrandURL ?? this.wmBrandURL,
      wmPosition: wmPosition ?? this.wmPosition,
    );
  }
}
