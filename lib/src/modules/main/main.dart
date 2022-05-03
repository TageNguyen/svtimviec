import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/modules/main/main_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MainBloC>(create: (context) => MainBloC()),
      ],
      child: UserManager.typeRole == TypeRole.recruiter
          ? const RecruiterMainPage()
          : const StudentMainPage(),
    );
  }
}
