import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_services.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/recruiter_profile/recruiter_profile_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/recruiter_profile/recruiter_profile_screen.dart';

class RecruiterProfilePage extends StatelessWidget {
  final int recruiterId;
  const RecruiterProfilePage({Key? key, required this.recruiterId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProfileServices>(
          create: (context) => ProfileServices(),
        ),
        ProxyProvider<ProfileServices, RecruiterProfileBloC>(
          update: (context, profileApi, previous) =>
              previous ?? RecruiterProfileBloC(profileApi, recruiterId),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const RecruiterProfileScreen(),
    );
  }
}
