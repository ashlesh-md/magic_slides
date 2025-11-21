import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_target.dart';
import 'package:magic_slides/feature/home/domain/model/water_mark_position.dart';
import 'package:magic_slides/network/requests/presentation_request.dart';

class Mapper {
  static PresentationRequest buildPresentationRequest({
    required String topic,
    required String extraInfoSource,
    required String email,
    required String accessId,
    required PresentationSettingsModel settings,
  }) {
    return PresentationRequest(
      topic: topic,
      extraInfoSource: extraInfoSource,
      email: email,
      accessId: accessId,
      template: settings.template,
      language: settings.language,
      slideCount: settings.slideCount,
      aiImages: settings.aiImages,
      imageForEachSlide: settings.imageEachSlide,
      googleImage: settings.googleImages,
      googleText: settings.googleText,
      model: settings.model,
      presentationFor: settings.presentationFor.label,
      watermark: Watermark(
        width: settings.wmWidth.toString(),
        height: settings.wmHeight.toString(),
        brandURL: settings.wmBrandURL,
        position: settings.wmPosition.label,
      ),
    );
  }
}
