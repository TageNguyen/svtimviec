import 'package:student_job_applying/src/utils/utils.dart';

enum TypeRole { student, recruiter }

extension TypeRoleEX on TypeRole {
  String get rawData {
    switch (this) {
      case TypeRole.student:
        return 'STUDENT';
      case TypeRole.recruiter:
        return 'RECRUITER';
      default:
        return toString();
    }
  }

  TypeRole fromRawData(String rawData) {
    switch (rawData) {
      case 'RECRUITER':
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
      default:
        return toString();
    }
  }
}
