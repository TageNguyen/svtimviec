import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_parameter.dart';

// used for login request
class LoginRequestModel {
  String email = '';
  String password = '';
  TypeRole typeRole = TypeRole.student;

  Map<String, dynamic> toJson() {
    return {
      ApiParameter.email: email,
      ApiParameter.password: password,
      ApiParameter.typeRole: typeRole.rawData,
    };
  }

  bool get isEnoughRequiredInformations =>
      email.isNotEmpty && password.isNotEmpty;
}
