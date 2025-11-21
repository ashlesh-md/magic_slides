enum TemplateType { editable, defaultType }

extension TemplateTypeExt on TemplateType {
  String get label {
    switch (this) {
      case TemplateType.editable:
        return "Editable";
      case TemplateType.defaultType:
        return "Default";
    }
  }
}
