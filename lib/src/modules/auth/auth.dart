import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/auth/login/login_screen.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [],
      child: const LoginScreen(),
    );
  }
}
