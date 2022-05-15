import 'package:rxdart/subjects.dart';
import 'package:student_job_applying/src/models/request_models/update_password_request_model.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class ChangePasswordBloC extends BloC {
  final ProfileApi profileApi;

  ChangePasswordBloC(this.profileApi);

  // manage change password button state
  final _changePasswordButtonObject = BehaviorSubject<bool>();
  Stream<bool> get changePasswordButtonState =>
      _changePasswordButtonObject.stream;

  // manage  eye button status (enable/disable)
  // used for showing and hiding password
  final _eyeButtonObject = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get eyeButtonStatusStream => _eyeButtonObject.stream;

  UpdatePasswordRequestModel requestModel = UpdatePasswordRequestModel();

  Future<void> updatePassword() {
    return profileApi.updatePassword(requestModel);
  }

  void updateChangePasswordButtonState() {
    _changePasswordButtonObject.add(requestModel.isEnoughRequiredInformations);
  }

  void changeEyeButtonStatus() {
    _eyeButtonObject.add(!_eyeButtonObject.value);
  }

  @override
  void dispose() {
    _changePasswordButtonObject.close();
    _eyeButtonObject.close();
  }
}
