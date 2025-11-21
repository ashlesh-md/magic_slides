import 'dart:io';

import 'package:flutter/material.dart';
import 'package:magic_slides/core/theme/text_styles.dart';
import 'package:share_plus/share_plus.dart';

class AppUtils {
  static SnackBar buildAppSnackBar(BuildContext context, String message) {
    final scheme = Theme.of(context).colorScheme;

    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(milliseconds: 1000),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 80, left: 30, right: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Center(
        child: Container(
          decoration: BoxDecoration(
            color: scheme.brightness == Brightness.dark
                ? scheme.surfaceContainerHighest
                : scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Text(
            message,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyles.m3LabelMediumProminant.copyWith(
              color: scheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  static Future<ShareResult> shareFile({
    required List<File> files,
    String? fileName,
  }) {
     final rect = Platform.isIOS
        ? const Rect.fromLTWH(
            0, 0, 200, 200) 
        : null;
    return Share.shareXFiles(
      files
          .map(
            (e) => XFile(e.path),
          )
          .toList(),
      text: Platform.isIOS ? null : "$fileName - Sent via SuperFam",
      sharePositionOrigin: rect,
    );
  }
}
