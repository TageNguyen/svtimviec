import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_services.dart';
import 'package:student_job_applying/src/modules/auth/verify_email/verify_email_bloc.dart';
import 'package:student_job_applying/src/modules/auth/verify_email/verify_email_screen.dart';

class VerifyEmailPage extends StatelessWidget {
  final int userId;
  const VerifyEmailPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (context) => AuthServices(),
        ),
        ProxyProvider<AuthServices, VerifyEmailBloC>(
          update: (context, authServices, previous) =>
              previous ?? VerifyEmailBloC(authServices)
                ..userId = userId,
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const VerifyEmailScreen(),
    );
  }
}
