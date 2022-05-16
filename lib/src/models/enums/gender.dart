import 'package:student_job_applying/src/utils/app_strings.dart';

enum Gender { male, female, unknown }

extension GenderEX on Gender {
  int get rawData {
    switch (this) {
      case Gender.female:
        return 0;
      case Gender.male:
        return 1;
      default:
        return 2;
    }
  }

  static Gender fromIndex(int? index) {
    switch (index) {
      case 0:
        return Gender.female;
      case 1:
        return Gender.male;
      default:
        return Gender.unknown;
    }
  }

  String get name {
    switch (this) {
      case Gender.female:
        return AppStrings.female;
      case Gender.male:
        return AppStrings.male;
      default:
        return AppStrings.maleOrFemale;
    }
  }
}
