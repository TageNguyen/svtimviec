import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class StudentProfileBloC extends BloC {
  final ProfileApi profileApi;
  final int studentId;

  StudentProfileBloC(this.profileApi, this.studentId);

  /// get student profile via [studentId]
  Future<User> getStudentProfile() {
    return profileApi.getStudentInformations(studentId);
  }

  @override
  void dispose() {}
}
