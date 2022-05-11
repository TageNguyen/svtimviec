import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/recruiter_profile/recruiter_profile_bloc.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/extensions/exception_ex.dart';

class RecruiterProfileScreen extends StatelessWidget {
  const RecruiterProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User>(
          stream: context.read<RecruiterProfileBloC>().recruiterInformations,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return loadingWidget;
            }
            if (snapshot.hasError) {
              return errorScreen(
                  message: (snapshot.error as Exception).message);
            }
            User recruiter = snapshot.data!;
            return Center(
              child: Text(recruiter.name ?? 'a'),
            );
          }),
    );
  }
}
