import 'package:student_job_applying/src/models/request_models/required_informations_request_model.dart';
import 'package:student_job_applying/src/models/request_models/update_password_request_model.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/struct/api/base_api.dart';

abstract class ProfileApi extends BaseApi {
  /// get recruiter information via [id]
  Future<User> getRecruiterInformations(int id);

  /// get student information via [id]
  Future<User> getStudentInformations(int id);

  /// update user informations
  Future<void> updateUserInformations(
      RequiredInformationsRequestModel requestModel);

  /// update password
  Future<void> updatePassword(UpdatePasswordRequestModel requestModel);
}
