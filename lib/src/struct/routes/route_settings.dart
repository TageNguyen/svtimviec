import 'package:flutter/material.dart';
import 'package:student_job_applying/src/modules/auth/register/register_page.dart';
import 'package:student_job_applying/src/modules/auth/verify_email/verify_email_page.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/utils.dart';

extension GenerateRoute on RouteSettings {
  MaterialPageRoute<MaterialPageRoute<dynamic>> get generateRoute {
    switch (name) {
      case RouteNames.register:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case RouteNames.verifyEmail:
        return MaterialPageRoute(
            builder: (context) => VerifyEmailPage(userId: arguments as int));
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: const Center(
              child: Text(
                AppStrings.pageNotFound,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
    }
  }
}
