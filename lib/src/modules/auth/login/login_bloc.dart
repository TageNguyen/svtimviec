import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/models/request_models/login_request_model.dart';
import 'package:student_job_applying/src/models/response_models/login_response_model.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class LoginBloC extends BloC {
  final AuthApi authApi;

  LoginBloC(this.authApi);

  // manage  eye button status (enable/disable)
  // used for showing and hiding password
  final _eyeButtonObject = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get eyeButtonStatusStream => _eyeButtonObject.stream;

  // manage login button status (enable/disable)
  final _logibButtonObject = BehaviorSubject<bool>();
  Stream<bool> get loginButtonStatusStream => _logibButtonObject.stream;

  LoginRequestModel requestModel = LoginRequestModel();

  set email(String value) {
    requestModel.email = value.trim();
    _logibButtonObject.add(requestModel.isEnoughRequiredInformations);
  }

  set password(String value) {
    requestModel.password = value.trim();
    _logibButtonObject.add(requestModel.isEnoughRequiredInformations);
  }

  set typeRole(TypeRole value) => requestModel.typeRole = value;

  /// request login and return token if success
  Future<LoginResponseModel> login() async {
    return authApi.login(requestModel);
  }

  /// get user informations
  Future<User> getCurrentUserInformations() {
    return authApi.getCurrentUserInformations();
  }

  void changeEyeButtonStatus() {
    _eyeButtonObject.add(!_eyeButtonObject.value);
  }

  @override
  void dispose() {
    _eyeButtonObject.close();
    _logibButtonObject.close();
  }
}
