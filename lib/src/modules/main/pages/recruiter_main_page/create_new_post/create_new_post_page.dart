import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_services.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/create_new_post/create_new_post_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/create_new_post/create_new_post_screen.dart';

class CreateNewPostPage extends StatelessWidget {
  const CreateNewPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecruiterServices>(
          create: (context) => RecruiterServices(),
        ),
        ProxyProvider<RecruiterServices, CreateNewPostBloC>(
          update: (context, recruitmentApi, previous) =>
              previous ?? CreateNewPostBloC(recruitmentApi),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const CreateNewPostScreen(),
    );
  }
}
