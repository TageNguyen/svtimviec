import 'package:student_job_applying/src/models/request_models/login_request_model.dart';
import 'package:student_job_applying/src/struct/api/base_api.dart';

abstract class AuthApi extends BaseApi {
  /// request login then return token
  Future<String> login(LoginRequestModel model);
}
