import 'package:flutter/material.dart';
import 'package:magic_slides/core/theme/text_styles.dart';

class CustomAlertView extends StatelessWidget {
  final String title;
  final String? content;

  final String confirmText;
  final String? cancelText;

  final Function() confirmAction;
  final Function()? cancelAction;

  final Color? confirmColor;

  const CustomAlertView({
    super.key,
    required this.title,
    this.content,
    required this.confirmText,
    this.cancelText,
    required this.confirmAction,
    this.cancelAction,
    this.confirmColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: CustomTextStyles.m3TitleMedium),
              if (content != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(content!, style: CustomTextStyles.m3BodyMedium),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (cancelAction != null) ...[
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: cancelAction,
                          child: Text(
                            cancelText ?? "",
                            style: CustomTextStyles.m3LabelMedium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: SizedBox(
                      height: 36,
                      child: FilledButton(
                        onPressed: confirmAction,
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.all(4.0),
                          backgroundColor: confirmColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          confirmText,
                          style: CustomTextStyles.m3LabelMedium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
