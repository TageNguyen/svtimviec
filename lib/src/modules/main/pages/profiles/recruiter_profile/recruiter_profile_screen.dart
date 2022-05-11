import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/recruiter_profile/recruiter_profile_bloc.dart';
import 'package:student_job_applying/src/utils/app_style/app_colors.dart';
import 'package:student_job_applying/src/utils/app_style/app_text_styles.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/extensions/exception_ex.dart';
import 'package:url_launcher/url_launcher.dart';

class RecruiterProfileScreen extends StatelessWidget {
  const RecruiterProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: StreamBuilder<User>(
          stream: context.read<RecruiterProfileBloC>().recruiterInformations,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return loadingWidget;
            }
            if (snapshot.hasError) {
              return errorScreen(
                  message: (snapshot.error as Exception).message);
            }
            User recruiter = snapshot.data!;
            return _buildRecruiterProfile(context, recruiter);
          }),
    );
  }

  Widget _buildRecruiterProfile(BuildContext context, User recruiter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildAppBar(context, recruiter.companyName),
        Expanded(child: _buildScrollableView(context, recruiter)),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, String? companyName) {
    return AppBar(
      title: Text(companyName ?? ''),
      centerTitle: true,
    );
  }

  Widget _buildScrollableView(BuildContext context, User recruiter) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildCompanyAndRecruiterImage(
            context, recruiter.companyImage ?? '', recruiter.avatar ?? ''),
        const SizedBox(height: 8.0),
        _buildRecruiterInformations(context, recruiter),
        _buildCompanyInformations(context, recruiter),
      ],
    );
  }

  Widget _buildCompanyAndRecruiterImage(
      BuildContext context, String companyImage, String recruiterAvatar) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          color: AppColors.white,
          margin: EdgeInsets.only(bottom: screenSize.width / 5),
          height: screenSize.height / 4,
          width: screenSize.width,
          child: buildNetworkImage(companyImage),
        ),
        buildNetworkCircleAvatar(recruiterAvatar, size: screenSize.width / 2.5),
      ],
    );
  }

  Widget _buildRecruiterInformations(BuildContext context, User recruiter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          recruiter.name ?? '',
          style: AppTextStyles.defaultSemibold.copyWith(fontSize: 20),
        ),
        Text(
          recruiter.email ?? '',
          style: AppTextStyles.defaultRegular,
        ),
        Text(
          recruiter.phone ?? '',
          style: AppTextStyles.defaultRegular,
        ),
      ],
    );
  }

  Widget _buildCompanyInformations(BuildContext context, User recruiter) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.companyInformations,
            style: AppTextStyles.defaultMedium,
          ),
          const SizedBox(height: 8.0),
          Text(
            '${AppStrings.companyName}: ${recruiter.companyName}',
            style: AppTextStyles.defaultRegular,
          ),
          const SizedBox(height: 4.0),
          Text(
            '${AppStrings.address}: ${recruiter.address ?? ''}',
            style: AppTextStyles.defaultRegular,
          ),
          const SizedBox(height: 4.0),
          _buildCompanyWebsite(context, recruiter.website ?? ''),
        ],
      ),
    );
  }

  Widget _buildCompanyWebsite(BuildContext context, String website) {
    return Row(
      children: [
        const Text(
          '${AppStrings.website}:',
          style: AppTextStyles.defaultRegular,
        ),
        const SizedBox(width: 4.0),
        Expanded(
          child: SelectableText(
            website,
            onTap: () => launchLink(website),
            style: const TextStyle(fontSize: 16, color: AppColors.primaryBlue),
            toolbarOptions: const ToolbarOptions(copy: true, selectAll: true),
          ),
        ),
      ],
    );
  }

  void launchLink(String link) {
    Uri url = Uri.parse(link);
    launchUrl(url).catchError((_) {
      showToastMessage(AppStrings.couldNotLaunchLink);
    });
  }
}
