import 'package:flutter/material.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class CandidateItem extends StatelessWidget {
  final User candidate;
  const CandidateItem({Key? key, required this.candidate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: AppColors.noColor,
      highlightColor: AppColors.noColor,
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8.0),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildNetworkCircleAvatar(candidate.avatar ?? '', size: 46.0),
            const SizedBox(width: 12.0),
            _buildCandidateInformations(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateInformations(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${candidate.name}',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          '${candidate.email}',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
