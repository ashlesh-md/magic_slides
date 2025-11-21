enum PresentationTarget { student, teacher, business }

extension PresentationTargetExt on PresentationTarget {
  String get label {
    switch (this) {
      case PresentationTarget.student:
        return 'Student';
      case PresentationTarget.teacher:
        return 'Teacher';
      case PresentationTarget.business:
        return 'Business';
    }
  }
}
