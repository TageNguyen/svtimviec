import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/post_report.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/recruitment_post_detail/recruitment_post_detail_bloc.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class RecruitmentPostComment extends StatefulWidget {
  final List<PostReport> listReport;
  const RecruitmentPostComment({Key? key, required this.listReport})
      : super(key: key);

  @override
  State<RecruitmentPostComment> createState() => _RecruitmentPostCommentState();
}

class _RecruitmentPostCommentState extends State<RecruitmentPostComment> {
  final TextEditingController _commentController =
      TextEditingController(text: '');

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.comment}: ',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 12.0),
        for (var report in widget.listReport) _buildComment(context, report),
        const SizedBox(height: 8.0),
        _buildCommentInputField(context),
      ],
    );
  }

  Widget _buildComment(BuildContext context, PostReport report) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: AppColors.tintLighter,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildNetworkCircleAvatar(report.avatar),
          const SizedBox(width: 5.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.name,
                  style: AppTextStyles.defaultSemibold.copyWith(fontSize: 14),
                ),
                Text(
                  report.comment,
                  style: AppTextStyles.defaultRegular.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputField(BuildContext context) {
    var bloC = context.read<RecruitmentPostDetailBloC>();
    return StreamBuilder<bool>(
      stream: bloC.canPostCommentState,
      builder: (_, snapshot) {
        bool canComment = snapshot.data ?? false;
        if (!canComment) {
          return const SizedBox.shrink();
        }
        return Row(
          children: [
            Expanded(
              child: InputTextField(
                controller: _commentController,
                hintText: AppStrings.comment,
                fillColor: AppColors.tintLighter,
                hintStyle: AppTextStyles.greyRegular,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (comment) => bloC.comment = comment.trim(),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                maxLength: 200,
              ),
            ),
            _buildSendCommentButton(context),
          ],
        );
      },
    );
  }

  Widget _buildSendCommentButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (_commentController.text.isNotEmpty) {
          postComment();
        }
      },
      icon: const Icon(
        Icons.send,
        color: AppColors.primaryBlue,
      ),
    );
  }

  void postComment() {
    showConfirmDialog(
      context,
      title: '${AppStrings.areYouSureThatYouWantToPostCommentForThisPost}?',
      message: AppStrings.youWillNotBeAbleToUndoYourCommentation,
      actionText: AppStrings.comment,
    ).then((confirm) {
      if (confirm) {
        context.read<RecruitmentPostDetailBloC>().commentPost().then((_) {
          showToastMessage(AppStrings.postCommentSuccessfully);
        }).catchError((error) {
          showToastMessage(error.message);
        });
      }
      _commentController.clear();
    });
  }
}
