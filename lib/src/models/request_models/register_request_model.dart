import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_parameter.dart';

class RegisterRequestModel {
  String email = '';
  String password = '';
  String confirmPassword = '';
  TypeRole typeRole = TypeRole.student;
  String name = '';

  Map<String, dynamic> toJson() {
    return {
      ApiParameter.email: email,
      ApiParameter.password: password,
      ApiParameter.confirmPassword: confirmPassword,
      ApiParameter.typeRole: typeRole.rawData,
      ApiParameter.name: name,
    };
  }

  bool get isEnoughRequiredInformations =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      name.isNotEmpty &&
      confirmPassword.isNotEmpty;
}
