import 'package:student_job_applying/src/utils/app_strings.dart';

// lương cố định hoặc thỏa thuận
enum SalaryType { fixed, wage }

extension SalaryTypeEX on SalaryType {
  int get rawData {
    switch (this) {
      case SalaryType.wage:
        return 2;
      default:
        return 1;
    }
  }

  static SalaryType fromIndex(int? index) {
    switch (index) {
      case 2:
        return SalaryType.wage;
      default:
        return SalaryType.fixed;
    }
  }

  String get name {
    switch (this) {
      case SalaryType.wage:
        return AppStrings.wageSalary;
      case SalaryType.fixed:
        return AppStrings.fixedSalary;
      default:
        return toString();
    }
  }
}
