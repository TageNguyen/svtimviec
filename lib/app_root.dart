import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/auth/auth.dart';
import 'package:student_job_applying/src/modules/main/main.dart';

/// the root of app
class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      builder: (context, snapshot) {
        bool logged = snapshot.data != null;
        if (logged) {
          return const Main();
        } else {
          return const Auth();
        }
      },
      stream: context.read<UserManager>().currentUser,
    );
  }
}
