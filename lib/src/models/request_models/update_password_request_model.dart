import 'package:student_job_applying/src/struct/api/api_util/api_parameter.dart';

class UpdatePasswordRequestModel {
  String oldPassword = '';
  String newPassword = '';
  String confirmNewPassword = '';

  Map<String, dynamic> toJson() {
    return {
      ApiParameter.oldPassword: oldPassword,
      ApiParameter.newPassword: newPassword,
      ApiParameter.confirmNewPassword: confirmNewPassword,
    };
  }

  bool get isEnoughRequiredInformations =>
      oldPassword.isNotEmpty &&
      newPassword.isNotEmpty &&
      confirmNewPassword.isNotEmpty;
}
