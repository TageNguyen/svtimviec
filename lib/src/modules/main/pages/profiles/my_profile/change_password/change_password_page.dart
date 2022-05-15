import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_services.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/my_profile/change_password/change_password_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/my_profile/change_password/change_password_screen.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProfileServices>(
          create: (_) => ProfileServices(),
        ),
        ProxyProvider<ProfileServices, ChangePasswordBloC>(
          update: (context, profileApi, previous) =>
              previous ?? ChangePasswordBloC(profileApi),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const ChangePasswordScreen(),
    );
  }
}
