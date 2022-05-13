import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<UserManager>().clear();
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.root, (route) => false);
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
