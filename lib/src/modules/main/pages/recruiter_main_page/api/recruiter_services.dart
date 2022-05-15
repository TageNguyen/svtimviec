import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/models/job_category.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_api.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_parameter.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_url.dart';

class RecruiterServices extends RecruiterApi {
  @override
  Future<User> getListCandidates(int postId) {
    return getMethod('${ApiUrl.getListCandidates}/$postId')
        .then((res) => res['data'].map<User>((e) => User.fromJson(e)).toList());
  }

  @override
  Future<List<JobCategory>> getListJobCategories() {
    return getMethod(ApiUrl.getListJobCategories).then((res) =>
        res['data'].map<JobCategory>((e) => JobCategory.fromJson(e)).toList());
  }

  @override
  Future<List<RecruitmentPost>> getPostsHistory(int page,
      {int pageSize = kDefaultPageSize}) {
    return getMethod(ApiUrl.getPostsHistory, param: {
      ApiParameter.page: '$page',
      ApiParameter.perPage: '$pageSize'
    }).then((res) => res['data']
        .map<RecruitmentPost>((e) => RecruitmentPost.fromJson(e))
        .toList());
  }

  @override
  Future<RecruitmentPost> getRecruitmentDetail(int postId) {
    return getMethod('${ApiUrl.getRecruitmentDetail}/$postId')
        .then((res) => RecruitmentPost.fromJson(res['data']));
  }

  @override
  Future<void> createNewRecruitmentPost() {
    // TODO: implement createNewRecruitmentPost
    throw UnimplementedError();
  }

  @override
  Future<void> updateRecruitmentPost(RecruitmentPost post) {
    return putMethod(
      '${ApiUrl.updateRecruitmentPost}/${post.id}}',
      body: post.toJson(),
    );
  }

  @override
  Future<void> deleteRecruitmentPost(int postId) {
    return deleteMethod('${ApiUrl.deleteRecruitmentPost}/$postId');
  }
}
