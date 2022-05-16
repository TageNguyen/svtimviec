import 'package:student_job_applying/src/models/request_models/update_password_request_model.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/models/request_models/required_informations_request_model.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_api.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_url.dart';

class ProfileServices extends ProfileApi {
  @override
  Future<User> getRecruiterInformations(int id) {
    return getMethod('${ApiUrl.getRecruiterInformations}/$id')
        .then((res) => User.fromJson(res['data']));
  }

  @override
  Future<User> getStudentInformations(int id) {
    return getMethod('${ApiUrl.getStudentInformations}/$id')
        .then((res) => User.fromJson(res['data']));
  }

  @override
  Future<void> updatePassword(UpdatePasswordRequestModel requestModel) {
    return postMethod(ApiUrl.updatePassword, body: requestModel.toJson());
  }

  @override
  Future<void> updateUserInformations(
      RequiredInformationsRequestModel requestModel) {
    return postMethod(ApiUrl.updateUserInformations,
        body: requestModel.toJson());
  }
}
