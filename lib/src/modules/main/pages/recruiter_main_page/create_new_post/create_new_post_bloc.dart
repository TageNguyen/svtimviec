import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/job_category.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class CreateNewPostBloC extends BloC {
  final RecruiterApi recruiterApi;

  CreateNewPostBloC(this.recruiterApi);

  late List<JobCategory> jobCategories = [];
  RecruitmentPost post = RecruitmentPost();
  JobCategory jobCategory = JobCategory();

  // manage post button state
  final _postButtonObject = BehaviorSubject<bool>();
  Stream<bool> get postButtonState => _postButtonObject.stream;

  /// create new post
  Future<void> createNewPost() async {
    post.jobCategory = jobCategory;
    await recruiterApi.createNewRecruitmentPost(post);
  }

  Future<void> getJobCategories() async {
    jobCategories = await recruiterApi.getListJobCategories();
  }

  void updatePostButtonState() {
    _postButtonObject.add(post.isEnoughRequireInformations() &&
        jobCategory.isEnoughInformations());
  }

  @override
  void dispose() {
    _postButtonObject.close();
  }
}
