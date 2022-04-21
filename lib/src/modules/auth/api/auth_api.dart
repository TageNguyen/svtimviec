import 'package:student_job_applying/src/models/request_models/login_request_model.dart';
import 'package:student_job_applying/src/models/request_models/register_request_model.dart';
import 'package:student_job_applying/src/models/response_models/login_response_model.dart';
import 'package:student_job_applying/src/struct/api/base_api.dart';

abstract class AuthApi extends BaseApi {
  /// request login then return a LoginResponseModel
  Future<LoginResponseModel> login(LoginRequestModel model);

  // request register then return [user_id] if success
  Future<int> register(RegisterRequestModel model);

  // request verify email
  Future<void> verifyEmail(int userId, String verifyCode);
}
