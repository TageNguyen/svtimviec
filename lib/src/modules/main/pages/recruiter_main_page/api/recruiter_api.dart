import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/models/job_category.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/struct/api/base_api.dart';

abstract class RecruiterApi extends BaseApi {
  /// get list recruitment posts posted by user
  Future<List<RecruitmentPost>> getPostsHistory(int page,
      {int pageSize = kDefaultPageSize});

  /// get recruitment post detail via [postId]
  Future<RecruitmentPost> getRecruitmentDetail(int postId);

  /// get list candidates apply for recruitment post via [postId]
  Future<User> getListCandidates(int postId);

  /// get list categories
  Future<List<JobCategory>> getListJobCategories();

  /// create new recruitment post
  Future<void> createNewRecruitmentPost();

  /// update recruitment post
  Future<void> updateRecruitmentPost();

  /// delete recruitment post via [postId]
  Future<void> deleteRecruitmentPost(int postId);
}
