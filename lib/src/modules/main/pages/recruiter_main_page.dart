import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';

class RecruiterMainPage extends StatelessWidget {
  const RecruiterMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('RecruiterMainPage'),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                context.read<UserManager>().clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.root, (route) => false);
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
