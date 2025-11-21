enum WatermarkPosition { topLeft, topRight, bottomLeft, bottomRight }

extension WatermarkPositionExt on WatermarkPosition {
  String get label {
    switch (this) {
      case WatermarkPosition.topLeft:
        return 'TopLeft';
      case WatermarkPosition.topRight:
        return 'TopRight';
      case WatermarkPosition.bottomLeft:
        return 'BottomLeft';
      case WatermarkPosition.bottomRight:
        return 'BottomRight';
    }
  }
}
