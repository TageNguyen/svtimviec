import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_services.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_services.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/my_profile/my_profile_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/my_profile/pages/my_recruiter_profile_page.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/my_profile/pages/my_student_profile_page.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthServices>(
          create: (_) => AuthServices(),
        ),
        Provider<ProfileServices>(
          create: (_) => ProfileServices(),
        ),
        ProxyProvider2<ProfileServices, AuthServices, MyProfileBloC>(
          update: (context, profileApi, authApi, previous) =>
              previous ?? MyProfileBloC(profileApi, authApi),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: UserManager.typeRole == TypeRole.student
          ? const MyStudentProfilePage()
          : const MyRecruiterProfilePage(),
    );
  }
}
