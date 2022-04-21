import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/request_models/register_request_model.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class RegisterBloC extends BloC {
  final AuthApi authApi;

  RegisterBloC(this.authApi);

  // manage  eye button status (enable/disable)
  // used for showing and hiding password
  final _eyeButtonObject = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get eyeButtonStatusStream => _eyeButtonObject.stream;

  // manage login button status (enable/disable)
  final _registerButtonObject = BehaviorSubject<bool>();
  Stream<bool> get registerButtonStatusStream => _registerButtonObject.stream;

  RegisterRequestModel requestModel = RegisterRequestModel();

  // request register and return user_id if success
  Future<int> register() async {
    return authApi.register(requestModel);
  }

  void updateRegisterButtonStatus() {
    _registerButtonObject.add(requestModel.isEnoughRequiredInformations);
  }

  void changeEyeButtonStatus() {
    _eyeButtonObject.add(!_eyeButtonObject.value);
  }

  @override
  void dispose() {
    _eyeButtonObject.close();
    _registerButtonObject.close();
  }
}
