import 'package:student_job_applying/src/modules/auth/api/auth_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class LoginBloC extends BloC {
  final AuthApi authApi;

  LoginBloC(this.authApi);
  @override
  void dispose() {}
}
