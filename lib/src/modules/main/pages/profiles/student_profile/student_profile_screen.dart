import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/student_profile/student_profile_bloc.dart';
import 'package:student_job_applying/src/utils/app_style/app_colors.dart';
import 'package:student_job_applying/src/utils/app_style/app_text_styles.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/extensions/exception_ex.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder<User>(
        future: context.read<StudentProfileBloC>().getStudentProfile(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingWidget;
          }
          if (snapshot.hasError) {
            return errorScreen(message: (snapshot.error as Exception).message);
          }
          User student = snapshot.data!;
          return _buildScrollableView(context, student);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.candidate),
      centerTitle: true,
    );
  }

  Widget _buildScrollableView(BuildContext context, User student) {
    Size screenSize = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Center(
          child: buildNetworkCircleAvatar(student.avatar ?? '',
              size: screenSize.width / 2.5),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: Text(
            student.name ?? '',
            style: AppTextStyles.defaultSemibold.copyWith(fontSize: 20),
          ),
        ),
        const SizedBox(height: 24.0),
        _buildInformations(AppStrings.gender, student.gender?.name ?? ''),
        const SizedBox(height: 12.0),
        _buildInformations(AppStrings.age, '${student.age ?? 0}'),
        const SizedBox(height: 12.0),
        _buildInformations(AppStrings.address, student.address ?? ''),
        const SizedBox(height: 12.0),
        _buildInformations(AppStrings.phoneNumber, student.phone ?? ''),
        const SizedBox(height: 12.0),
        _buildInformations(AppStrings.email, student.email ?? ''),
      ],
    );
  }

  Widget _buildInformations(String title, String infor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '$title: ',
          style: AppTextStyles.defaultMedium,
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: AppColors.black1A,
              width: 0.5,
            ),
            color: AppColors.black1A.withOpacity(0.1),
          ),
          child: Text(
            infor,
            style: AppTextStyles.defaultMedium,
          ),
        ),
      ],
    );
  }
}
