import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_services.dart';
import 'package:student_job_applying/src/modules/auth/register/register_bloc.dart';
import 'package:student_job_applying/src/modules/auth/register/register_screen.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (context) => AuthServices(),
        ),
        ProxyProvider<AuthServices, RegisterBloC>(
          update: (context, authServices, previous) =>
              previous ?? RegisterBloC(authServices),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const RegisterScreen(),
    );
  }
}
