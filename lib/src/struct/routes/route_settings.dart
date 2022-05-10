import 'package:flutter/material.dart';
import 'package:student_job_applying/app_root.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/auth/login/login_page.dart';
import 'package:student_job_applying/src/modules/auth/register/register_page.dart';
import 'package:student_job_applying/src/modules/auth/update_required_informations/update_required_informations_page.dart';
import 'package:student_job_applying/src/modules/auth/verify_email/verify_email_page.dart';
import 'package:student_job_applying/src/modules/main/main.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/recruitment_post_detail/recruitment_post_detail_page.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/utils.dart';

extension GenerateRoute on RouteSettings {
  MaterialPageRoute<MaterialPageRoute<dynamic>> get generateRoute {
    switch (name) {
      case RouteNames.root:
        return MaterialPageRoute(builder: (context) => const AppRoot());
      case RouteNames.main:
        return MaterialPageRoute(builder: (context) => const Main());
      case RouteNames.login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case RouteNames.register:
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case RouteNames.verifyEmail:
        return MaterialPageRoute(
            builder: (context) => VerifyEmailPage(userId: arguments as int));
      case RouteNames.updateRequiredInformations:
        return MaterialPageRoute(
            builder: (context) => const UpdateRequiredInformationsPage());
      case RouteNames.recruitmentPostDetail:
        return MaterialPageRoute(
            builder: (context) => RecruitmentPostDetailPage(
                recruitmentPost: arguments as RecruitmentPost));
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
