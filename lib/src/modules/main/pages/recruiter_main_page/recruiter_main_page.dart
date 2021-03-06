import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_services.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/recruiter_main_page_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/recruiter_main_screen.dart';

class RecruiterMainPage extends StatelessWidget {
  const RecruiterMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecruiterServices>(create: (context) => RecruiterServices()),
        ProxyProvider<RecruiterServices, RecruiterMainPageBloC>(
          update: (context, recruitmentApi, previous) =>
              previous ?? RecruiterMainPageBloC(recruitmentApi),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const RecruiterMainScreen(),
    );
  }
}
