import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/extensions/date_time_ex.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/recruitment_post_detail/recruitment_post_detail_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/recruitment_post_detail/widgets/recruitment_post_comment.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/app_style/app_text_styles.dart';
import 'package:student_job_applying/src/utils/helpers.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class RecruitmentPostDetailScreen extends StatelessWidget {
  const RecruitmentPostDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getRecruitmentPostDetail(context);
    return KeyboardDismisser(
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<RecruitmentPost>(
              stream:
                  context.read<RecruitmentPostDetailBloC>().recruitmentDetail,
              initialData:
                  context.read<RecruitmentPostDetailBloC>().recruitmentPost,
              builder: (context, snapshot) {
                RecruitmentPost post = snapshot.data!;
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildCompanyImage(context, post.recruiter?.companyImage),
                      _buildPostInformations(context, post),
                    ],
                  ),
                );
              },
            ),
            const Positioned(
              top: 28.0,
              left: 4.0,
              child: BackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostInformations(BuildContext context, RecruitmentPost post) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${post.createdAt?.ddmmyyyy}',
            style: AppTextStyles.greyRegular.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 8.0),
          Text(
            '${post.recruiter?.companyName} ${AppStrings.hire}: ',
            style: AppTextStyles.defaultSemibold,
          ),
          const SizedBox(height: 8.0),
          Text(
            post.jobName,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 4.0),
          Text(
            post.jobDescription,
          ),
          const SizedBox(height: 4.0),
          _buildSalaryInformations(context, post),
          const SizedBox(height: 4.0),
          _buildRequiredInformations(context, post),
          const SizedBox(height: 12.0),
          Align(
            alignment: Alignment.centerLeft,
            child: _buildRecruiterInformations(context, post.recruiter),
          ),
          const SizedBox(height: 4.0),
          _buildContactAddress(context, post),
          const SizedBox(height: 16.0),
          _buildButtons(context),
          const SizedBox(height: 16.0),
          RecruitmentPostComment(listReport: post.reports ?? []),
        ],
      ),
    );
  }

  Widget _buildCompanyImage(BuildContext context, String? companyImage) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: buildNetworkImage(companyImage ?? ''),
    );
  }

  Widget _buildRecruiterInformations(BuildContext context, User? recruiter) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.recruiterProfile,
            arguments: recruiter?.recruiterId);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildNetworkCircleAvatar(
            recruiter?.avatar ?? '',
            size: 50.0,
          ),
          const SizedBox(width: 5.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${recruiter?.name}',
                  style: AppTextStyles.defaultSemibold,
                ),
                Text(
                  '${recruiter?.email}',
                  style: AppTextStyles.greyRegular.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryInformations(
      BuildContext context, RecruitmentPost recruitmentPost) {
    return RichText(
      text: TextSpan(
        text: '${recruitmentPost.salaryType.name}: ',
        style: Theme.of(context).textTheme.bodyText1,
        children: <TextSpan>[
          TextSpan(
            text: recruitmentPost.salaryType == SalaryType.fixed
                ? '${recruitmentPost.minSalary()} - ${recruitmentPost.maxSalary()}'
                : '',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredInformations(
      BuildContext context, RecruitmentPost post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.requirement}: ',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${AppStrings.gender}: ${post.gender?.name}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          '${AppStrings.age}: ${AppStrings.from} ${post.minAge}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Widget _buildContactAddress(BuildContext context, RecruitmentPost post) {
    return Text(
      '${AppStrings.pleaseContactUsAt}: ${post.recruiter?.companyAddress} ${AppStrings.orByEmailAddress}: ${post.recruiter?.email}',
      style: AppTextStyles.defaultRegular,
    );
  }

  Widget _applyButton(BuildContext context) {
    var bloC = context.read<RecruitmentPostDetailBloC>();
    return StreamBuilder<bool>(
      stream: bloC.applyButtonState,
      initialData: bloC.recruitmentPost.isApplied,
      builder: (_, snapshot) {
        bool isApplied = snapshot.data ?? false;
        return MaterialButton(
          height: 56,
          elevation: 0,
          onPressed: () {
            if (!isApplied) {
              applyForRecruitmentPost(context);
            }
          },
          color: isApplied ? AppColors.primaryBlue : AppColors.tintGreyLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Icon(
                  Icons.check,
                  color: isApplied ? AppColors.white : AppColors.darkBlue,
                ),
              ),
              Text(
                AppStrings.apply,
                style: TextStyle(
                  color: isApplied ? AppColors.white : AppColors.darkBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _saveButton(BuildContext context) {
    var bloC = context.read<RecruitmentPostDetailBloC>();
    return StreamBuilder<bool>(
      stream: bloC.saveButtonState,
      initialData: bloC.recruitmentPost.isSaved,
      builder: (_, snapshot) {
        bool isSaved = snapshot.data ?? false;
        return MaterialButton(
          height: 56,
          minWidth: 68,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          onPressed: () {
            if (isSaved) {
              unSaveRecruitmentPosts(context);
            } else {
              saveRecruitmentPosts(context);
            }
          },
          child: Icon(
            Icons.bookmark_sharp,
            color: isSaved ? AppColors.white : AppColors.primaryBlue,
          ),
          color: isSaved ? AppColors.primaryBlue : AppColors.tintGreyLight,
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _applyButton(context)),
        const SizedBox(width: 8),
        _saveButton(context),
      ],
    );
  }

  void getRecruitmentPostDetail(BuildContext context) {
    context
        .read<RecruitmentPostDetailBloC>()
        .getRecruitmentDetail()
        .catchError((error) {
      showToastMessage(error.message);
    });
  }

  void applyForRecruitmentPost(BuildContext context) {
    showConfirmDialog(
      context,
      title: '${AppStrings.areYouSureThatYouWantToApplyForThisPost}?',
      message: AppStrings.youWillNotBeAbleToUndoYourApplication,
      actionText: AppStrings.apply,
    ).then((confirm) {
      if (confirm) {
        context
            .read<RecruitmentPostDetailBloC>()
            .applyForRecruitmentPost()
            .then((_) {
          showToastMessage(AppStrings.submitApplicationSuccessfully);
        }).catchError((error) {
          showToastMessage(error.message);
        });
      }
    });
  }

  void saveRecruitmentPosts(BuildContext context) {
    context.read<RecruitmentPostDetailBloC>().saveRecruitmentPost().then((_) {
      showToastMessage(AppStrings.savePostSuccessfully);
    }).catchError((error) {
      showToastMessage(error.message);
    });
  }

  void unSaveRecruitmentPosts(BuildContext context) {
    context.read<RecruitmentPostDetailBloC>().unSaveRecruitmentPost().then((_) {
      showToastMessage(AppStrings.unSavePostSuccessfully);
    }).catchError((error) {
      showToastMessage(error.message);
    });
  }
}
