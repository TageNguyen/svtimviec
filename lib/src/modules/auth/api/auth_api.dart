import 'package:student_job_applying/src/models/request_models/login_request_model.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_url.dart';
import 'package:student_job_applying/src/struct/api/base_api.dart';

/// Contains methods used for authentication api request
class AuthApi extends BaseApi {
  /// request login then return token
  Future<String> login(LoginRequestModel model) {
    return postMethod(
      ApiUrl.login,
      body: model.toJson(),
    ).then((result) => result['data']['token']);
  }
}
