import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class VerifyEmailBloC extends BloC {
  final AuthApi authApi;
  late int userId;

  VerifyEmailBloC(this.authApi);

  // manage verify button status (enable/disable)
  final _verifyButtonObject = BehaviorSubject<bool>();
  Stream<bool> get verifyButtonStatusStream => _verifyButtonObject.stream;

  String _verifyCode = '';

  /// save verifyCode and update verify button status
  set verifyCode(String value) {
    _verifyCode = value.trim();
    _verifyButtonObject.add(_verifyCode.isNotEmpty);
  }

  // request verify
  Future<void> verifyEmail() async {
    return authApi.verifyEmail(userId, _verifyCode);
  }

  @override
  void dispose() {
    _verifyButtonObject.close();
  }
}
