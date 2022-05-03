import 'package:student_job_applying/src/utils/app_strings.dart';

enum Gender { male, female }

extension GenderEX on Gender {
  int get rawData {
    switch (this) {
      case Gender.female:
        return 0;
      default:
        return 1;
    }
  }

  static Gender fromIndex(int? index) {
    switch (index) {
      case 0:
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  String get name {
    switch (this) {
      case Gender.female:
        return AppStrings.female;
      case Gender.male:
        return AppStrings.male;
      default:
        return toString();
    }
  }
}
