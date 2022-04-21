import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_services.dart';
import 'package:student_job_applying/src/modules/auth/login/login_bloc.dart';
import 'package:student_job_applying/src/modules/auth/login/login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (context) => AuthServices(),
        ),
        ProxyProvider<AuthServices, LoginBloC>(
          update: (context, authServices, previous) =>
              previous ?? LoginBloC(authServices),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const LoginScreen(),
    );
  }
}
