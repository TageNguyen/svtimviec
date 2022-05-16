import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_services.dart';
import 'package:student_job_applying/src/modules/auth/api/province_api.dart';
import 'package:student_job_applying/src/modules/auth/update_required_informations/pages/update_recruiter_required_informations_screen.dart';
import 'package:student_job_applying/src/modules/auth/update_required_informations/pages/update_student_required_informations_screen.dart';
import 'package:student_job_applying/src/modules/auth/update_required_informations/update_required_informations_bloc.dart';

class UpdateRequiredInformationsPage extends StatelessWidget {
  const UpdateRequiredInformationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserManager>(
          create: (_) => UserManager(),
        ),
        Provider<ProvinceApi>(
          create: (context) => ProvinceApi(),
        ),
        Provider<AuthServices>(
          create: (context) => AuthServices(),
        ),
        ProxyProvider2<AuthServices, ProvinceApi,
            UpdateRequiredInformationsBloC>(
          update: (context, authApi, provinceApi, previous) =>
              previous ?? UpdateRequiredInformationsBloC(authApi, provinceApi),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: UserManager.typeRole == TypeRole.recruiter
          ? const UpdateRecruiterRequiredInformationsScreen()
          : const UpdateStudentRequiredInformationsScreen(),
    );
  }
}
