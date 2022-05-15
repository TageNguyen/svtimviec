import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class ListCandidatesBloC extends BloC {
  final RecruiterApi recruiterApi;
  final RecruitmentPost post;

  ListCandidatesBloC(this.recruiterApi, this.post);

  /// get list candidates of post
  Future<List<User>> getListCandidates() {
    return recruiterApi.getListCandidates(post.id!);
  }

  @override
  void dispose() {}
}
