import 'package:flutter/material.dart';
import 'package:magic_slides/core/theme/text_styles.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_target.dart';
import 'package:magic_slides/feature/home/domain/model/template_type.dart';
import 'package:magic_slides/feature/home/domain/model/water_mark_position.dart';

class SettingsSummaryView extends StatelessWidget {
  final PresentationSettingsModel model;
  final VoidCallback onEditClicked;
  const SettingsSummaryView({
    super.key,
    required this.model,
    required this.onEditClicked,
  });

  String _presentFor(PresentationTarget p) {
    switch (p) {
      case PresentationTarget.student:
        return "Student";
      case PresentationTarget.teacher:
        return "Teacher";
      case PresentationTarget.business:
        return "Business";
    }
  }

  String _wmPosition(WatermarkPosition p) {
    switch (p) {
      case WatermarkPosition.topLeft:
        return "Top Left";
      case WatermarkPosition.topRight:
        return "Top Right";
      case WatermarkPosition.bottomLeft:
        return "Bottom Left";
      case WatermarkPosition.bottomRight:
        return "Bottom Right";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Current Presentation Settings",
                style: CustomTextStyles.m3TitleMediumProminant,
              ),

              Transform.translate(
                offset: Offset(12, 0),
                child: IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.edit),
                  onPressed: onEditClicked,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          _tile("Slide Count", model.slideCount.toString()),
          _tile("Template type", model.templateType.label),
          _tile("Language", model.language),
          _tile("Model", model.model),
          _tile("Template", model.template.isEmpty ? "None" : model.template),
          _tile("Presentation For", _presentFor(model.presentationFor)),

          const SizedBox(height: 10),
          const Text(
            "AI & Images",
            style: CustomTextStyles.m3TitleSmallProminent,
          ),
          const SizedBox(height: 6),

          _tile("AI Images", model.aiImages ? "Enabled" : "Disabled"),
          _tile(
            "Image Each Slide",
            model.imageEachSlide ? "Enabled" : "Disabled",
          ),
          _tile("Google Images", model.googleImages ? "Enabled" : "Disabled"),
          _tile("Google Text", model.googleText ? "Enabled" : "Disabled"),

          const SizedBox(height: 10),
          const Text(
            "Watermark",
            style: CustomTextStyles.m3TitleSmallProminent,
          ),
          const SizedBox(height: 6),

          _tile("Width", model.wmWidth.toString()),
          _tile("Height", model.wmHeight.toString()),
          _tile(
            "Brand URL",
            model.wmBrandURL.isEmpty ? "None" : model.wmBrandURL,
          ),
          _tile("Position", _wmPosition(model.wmPosition)),
        ],
      ),
    );
  }

  Widget _tile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(label, style: CustomTextStyles.m3BodyMedium),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: CustomTextStyles.m3BodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
