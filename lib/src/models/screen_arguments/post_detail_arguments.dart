import 'package:student_job_applying/src/models/recruitment_post.dart';

class PostDetailArguments {
  RecruitmentPost post;
  void Function() onDelete;
  void Function(RecruitmentPost newValue) onUpdated;
  PostDetailArguments(
      {required this.post, required this.onDelete, required this.onUpdated});
}
