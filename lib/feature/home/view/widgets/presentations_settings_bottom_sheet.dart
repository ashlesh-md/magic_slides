import 'package:flutter/material.dart';
import 'package:magic_slides/core/constants/template_constants.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_setting_model.dart';
import 'package:magic_slides/feature/home/domain/model/presentation_target.dart';
import 'package:magic_slides/feature/home/domain/model/template_type.dart';
import 'package:magic_slides/feature/home/domain/model/water_mark_position.dart';

class PresentationSettingsBottomSheet extends StatefulWidget {
  final PresentationSettingsModel model;
  const PresentationSettingsBottomSheet({super.key, required this.model});

  @override
  State<PresentationSettingsBottomSheet> createState() =>
      _PresentationSettingsBottomSheetState();
}

class _PresentationSettingsBottomSheetState
    extends State<PresentationSettingsBottomSheet> {
  late PresentationSettingsModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              const _SectionTitle("Presentation Settings"),
              _Section(
                children: [
                  _buildSlideCount(),
                  _buildLanguageDropdown(),

                  _DropdownSetting<TemplateType>(
                    label: "Template Type",
                    value: model.templateType,
                    items: TemplateType.values,
                    onChanged: (v) {
                      if (v == null) return;
                      setState(() {
                        model = model.copyWith(
                          templateType: v,
                          template: v == TemplateType.defaultType
                              ? TemplateConstants.defaultTemplates.first
                              : TemplateConstants.editableTemplates.first,
                        );
                      });
                    },
                    itemText: (TemplateType type) => type.label,
                  ),

                  _DropdownSetting<String>(
                    label: "Template",
                    value: model.template.isEmpty ? null : model.template,
                    items: model.templateType == TemplateType.editable
                        ? TemplateConstants.editableTemplates
                        : TemplateConstants.defaultTemplates,
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(template: v)),
                    itemText: (val) => val.toString(),
                  ),
                ],
              ),

              const _SectionTitle("AI & Images"),
              _Section(
                children: [
                  _SwitchSetting(
                    label: 'AI Images',
                    value: model.aiImages,
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(aiImages: v)),
                  ),
                  _SwitchSetting(
                    label: 'Image On Each Slide',
                    value: model.imageEachSlide,
                    onChanged: (v) => setState(
                      () => model = model.copyWith(imageEachSlide: v),
                    ),
                  ),
                  _SwitchSetting(
                    label: 'Google Images',
                    value: model.googleImages,
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(googleImages: v)),
                  ),
                  _SwitchSetting(
                    label: 'Google Text',
                    value: model.googleText,
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(googleText: v)),
                  ),
                ],
              ),

              const _SectionTitle("Model & Audience"),
              _Section(
                children: [
                  _DropdownSetting<String>(
                    label: "Model",
                    value: model.model,
                    items: const ['gpt-4', 'gpt-3.5'],
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(model: v)),
                    itemText: (val) => val.toString(),
                  ),
                  _DropdownSetting<PresentationTarget>(
                    label: "Presentation For",
                    value: model.presentationFor,
                    items: PresentationTarget.values,
                    onChanged: (v) => setState(
                      () => model = model.copyWith(presentationFor: v),
                    ),
                    itemText: (PresentationTarget target) => target.label,
                  ),
                ],
              ),

              const _SectionTitle("Watermark"),
              _Section(
                children: [
                  _NumberFieldSetting(
                    label: "Width",
                    value: model.wmWidth,
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(wmWidth: v)),
                  ),
                  _NumberFieldSetting(
                    label: "Height",
                    value: model.wmHeight,
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(wmHeight: v)),
                  ),
                  _TextFieldSetting(
                    label: "Brand URL",
                    initial: model.wmBrandURL,
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(wmBrandURL: v)),
                  ),
                  _DropdownSetting<WatermarkPosition>(
                    label: "Position",
                    value: model.wmPosition,
                    items: WatermarkPosition.values,
                    onChanged: (v) =>
                        setState(() => model = model.copyWith(wmPosition: v)),
                    itemText: (WatermarkPosition position) => position.label,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => Navigator.pop(context, model),
                child: const Text("Apply Settings"),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSlideCount() {
    return _SlideCountField(
      label: "Slide Count (4–50)",
      value: model.slideCount,
      onChanged: (v) {
        setState(() => model = model.copyWith(slideCount: v));
      },
    );
  }

  Widget _buildLanguageDropdown() {
    const langs = {
      'en': 'English',
      'hi': 'Hindi',
      'es': 'Spanish',
      'fr': 'French',
    };
    return _DropdownSetting<String>(
      label: "Language",
      value: model.language,
      items: langs.keys.toList(),
      onChanged: (v) => setState(() => model = model.copyWith(language: v)),
      itemText: (key) => key.toString(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final List<Widget> children;
  const _Section({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }
}

class _DropdownSetting<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemText;

  const _DropdownSetting({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.itemText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            isDense: true,
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(itemText(e))))
              .toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SlideCountField extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const _SlideCountField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_SlideCountField> createState() => _SlideCountFieldState();
}

class _SlideCountFieldState extends State<_SlideCountField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
          ),
          onChanged: (t) {
            if (t.isEmpty) return;

            int? v = int.tryParse(t);
            if (v == null) return;

            if (v < 4) v = 4;
            if (v > 50) v = 50;

            controller.value = TextEditingValue(
              text: v.toString(),
              selection: TextSelection.collapsed(offset: v.toString().length),
            );

            widget.onChanged(v);
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _SwitchSetting extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchSetting({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _NumberFieldSetting extends StatefulWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const _NumberFieldSetting({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<_NumberFieldSetting> createState() => _NumberFieldSettingState();
}

class _NumberFieldSettingState extends State<_NumberFieldSetting> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value.toString());
    focusNode = FocusNode();

    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        _commitValue();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _NumberFieldSetting oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value &&
        controller.text != widget.value.toString()) {
      controller.text = widget.value.toString();
    }
  }

  void _commitValue() {
    final raw = controller.text.trim();

    if (raw.isEmpty) return;

    final parsed = double.tryParse(raw);
    if (parsed == null) {
      controller.text = widget.value.toString();
      return;
    }

    widget.onChanged(parsed);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.blue, width: 1.4),
            ),
            isDense: true,
          ),

          onChanged: (text) {},

          onEditingComplete: () {
            _commitValue();
            FocusScope.of(context).unfocus();
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _TextFieldSetting extends StatefulWidget {
  final String label;
  final String initial;
  final ValueChanged<String> onChanged;

  const _TextFieldSetting({
    required this.label,
    required this.initial,
    required this.onChanged,
  });

  @override
  State<_TextFieldSetting> createState() => _TextFieldSettingState();
}

class _TextFieldSettingState extends State<_TextFieldSetting> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initial);
  }

  @override
  void didUpdateWidget(covariant _TextFieldSetting oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initial != widget.initial &&
        controller.text != widget.initial) {
      controller.text = widget.initial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            isDense: true,
          ),
          onChanged: widget.onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
