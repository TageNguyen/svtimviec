import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/job_category.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class PostDetailBloC extends BloC {
  final RecruiterApi recruiterApi;
  final RecruitmentPost post;

  PostDetailBloC(this.recruiterApi, this.post);

  // store recruitment post detail
  final _recruitmentObject = BehaviorSubject<RecruitmentPost>();
  Stream<RecruitmentPost> get recruitmentDetail => _recruitmentObject.stream;

  // manage edit button state
  final _editButtonObject = BehaviorSubject<bool>();
  Stream<bool> get editButtonState => _editButtonObject.stream;

  late RecruitmentPost postDetail;
  late JobCategory jobCategory;
  late List<JobCategory> jobCategories = [];

  set editMode(bool value) => _editButtonObject.add(value);

  /// get recruitment post detail
  Future<void> getRecruitmentDetail() async {
    postDetail = await recruiterApi.getRecruitmentDetail(post.id!);
    jobCategory = postDetail.jobCategory ?? JobCategory();
    _recruitmentObject.add(postDetail);
  }

  Future<void> getJobCategories() async {
    jobCategories = await recruiterApi.getListJobCategories();
  }

  /// update post
  Future<void> updatePost() async {
    postDetail.jobCategory = jobCategory;
    await recruiterApi.updateRecruitmentPost(postDetail);
    await getRecruitmentDetail();
  }

  /// delete post
  Future<void> deletePost() async {
    return recruiterApi.deleteRecruitmentPost(postDetail.id!);
  }

  @override
  void dispose() {
    _recruitmentObject.close();
    _editButtonObject.close();
  }
}
