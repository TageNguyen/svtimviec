import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/extensions/date_time_ex.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/models/screen_arguments/post_detail_arguments.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/recruiter_main_page_bloc.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class PostHistoryItem extends StatelessWidget {
  final RecruitmentPost recruitmentPost;
  const PostHistoryItem({Key? key, required this.recruitmentPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.noColor,
      highlightColor: AppColors.noColor,
      onTap: () {
        var bloC = context.read<RecruiterMainPageBloC>();
        Navigator.pushNamed(
          context,
          RouteNames.postDetail,
          arguments: PostDetailArguments(
            post: recruitmentPost,
            onDelete: () => bloC.deletePost(recruitmentPost.id),
            onUpdated: (post) => bloC.updatePost(post),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: AppColors.tintGreyLight,
              offset: Offset(0.0, 1.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRecruiterInformations(context, recruitmentPost.recruiter),
            Text(
              '${recruitmentPost.jobName}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 4.0),
            Text(
              '${recruitmentPost.jobDescription}',
            ),
            const SizedBox(height: 4.0),
            _buildSalaryInformations(context),
            const SizedBox(height: 4.0),
            _buildRequiredInformations(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSalaryInformations(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '${recruitmentPost.salaryType?.name}: ',
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

  Widget _buildRecruiterInformations(BuildContext context, User? recruiter) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildNetworkCircleAvatar(
          recruiter?.avatar ?? '',
          size: 40.0,
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${recruiter?.companyName}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                '${recruiter?.name}',
                style: AppTextStyles.greyRegular.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 4.0),
        Text(
          '${recruitmentPost.createdAt?.ddmmyyyy}',
          style: AppTextStyles.greyRegular.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRequiredInformations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.requirement}: ',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${AppStrings.gender}: ${recruitmentPost.gender?.name}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          '${AppStrings.age}: ${AppStrings.from} ${recruitmentPost.minAge}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
