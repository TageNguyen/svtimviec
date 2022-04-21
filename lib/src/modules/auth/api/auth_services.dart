import 'package:student_job_applying/src/models/request_models/login_request_model.dart';
import 'package:student_job_applying/src/models/request_models/register_request_model.dart';
import 'package:student_job_applying/src/models/response_models/login_response_model.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_api.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_url.dart';

class AuthServices extends AuthApi {
  @override
  Future<LoginResponseModel> login(LoginRequestModel model) {
    return postMethod(
      ApiUrl.login,
      body: model.toJson(),
    ).then((result) => LoginResponseModel.fromJson(result['data']));
  }

  @override
  Future<int> register(RegisterRequestModel model) {
    return postMethod(
      ApiUrl.register,
      body: model.toJson(),
    ).then((result) => result['data']['user_id']);
  }
}
