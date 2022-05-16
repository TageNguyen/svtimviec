import 'package:student_job_applying/src/utils/utils.dart';

enum TypeRole { student, recruiter, admin }

extension TypeRoleEX on TypeRole {
  String get rawData {
    switch (this) {
      case TypeRole.student:
        return 'STUDENT';
      case TypeRole.recruiter:
        return 'RECRUITER';
      case TypeRole.admin:
        return 'ADMIN';
      default:
        return toString();
    }
  }

  static TypeRole fromRawData(String? rawData) {
    switch (rawData) {
      case 'RECRUITER':
        return TypeRole.recruiter;
      case 'ADMIN':
        return TypeRole.admin;
      default:
        return TypeRole.student;
    }
  }

  static TypeRole fromIndex(int? index) {
    switch (index) {
      case 1:
        return TypeRole.admin;
      case 2:
        return TypeRole.recruiter;
      default:
        return TypeRole.student;
    }
  }

  String get name {
    switch (this) {
      case TypeRole.student:
        return AppStrings.student;
      case TypeRole.recruiter:
        return AppStrings.recruiter;
      case TypeRole.admin:
        return AppStrings.admin;
      default:
        return toString();
    }
  }
}
