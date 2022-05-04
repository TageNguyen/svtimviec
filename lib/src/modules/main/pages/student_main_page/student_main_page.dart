import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/api/recruitment_services.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/student_main_page_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/student_main_screen.dart';

class StudentMainPage extends StatelessWidget {
  const StudentMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecruitmentServices>(
          create: (context) => RecruitmentServices(),
        ),
        ProxyProvider<RecruitmentServices, StudentMainPageBloC>(
          update: (context, recruitmentApi, previous) =>
              previous ?? StudentMainPageBloC(recruitmentApi),
          dispose: (context, bloC) => bloC.dispose(),
        )
      ],
      child: StudentMainScreen(),
    );
  }
}
