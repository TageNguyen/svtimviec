import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_services.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/student_profile/student_profile_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/student_profile/student_profile_screen.dart';

class StudentProfilePage extends StatelessWidget {
  final int studentId;
  const StudentProfilePage({Key? key, required this.studentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProfileServices>(
          create: (context) => ProfileServices(),
        ),
        ProxyProvider<ProfileServices, StudentProfileBloC>(
          update: (context, profileApi, previous) =>
              previous ?? StudentProfileBloC(profileApi, studentId),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const StudentProfileScreen(),
    );
  }
}
