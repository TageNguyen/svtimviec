import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/api/recruitment_api.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_parameter.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_url.dart';

class RecruitmentServices extends RecruitmentApi {
  @override
  Future<List<RecruitmentPost>> getRecruitmentPosts(
      {int page = 1,
      SalaryType? salaryType,
      int? salaryFrom,
      int? salaryTo,
      int? minAge,
      Gender? gender,
      String keyword = ''}) {
    return getMethod(
      ApiUrl.getRecruitmentPosts,
      param: {
        ApiParameter.page: '$page',
        ApiParameter.salaryType: '${salaryType?.rawData ?? ''}',
        ApiParameter.salaryFrom: '${salaryFrom ?? ''}',
        ApiParameter.salaryTo: '${salaryTo ?? ''}',
        ApiParameter.minAge: '${minAge ?? ''}',
        ApiParameter.sex: '${gender?.rawData ?? 2}',
        ApiParameter.search: keyword,
      },
    ).then((res) => res['data']
        .map<RecruitmentPost>((e) => RecruitmentPost.fromJson(e))
        .toList());
  }

  @override
  Future<bool> applyForRecruitmentPost(String id) {
    return postMethod('${ApiUrl.applyForRecruitmentPost}/$id')
        .then((res) => res['data']);
  }

  @override
  Future<RecruitmentPost> getRecruitmentPostDetail(String id) {
    return getMethod('${ApiUrl.getRecruitmentPostDetail}/$id')
        .then((res) => RecruitmentPost.fromJson(res['data']));
  }

  @override
  Future<List<RecruitmentPost>> getSavedRecruitmentPosts({int page = 1}) {
    return getMethod(
      ApiUrl.getSavedRecruitmentPosts,
      param: {
        ApiParameter.page: '$page',
      },
    ).then((res) => res['data']
        .map<RecruitmentPost>((e) => RecruitmentPost.fromJson(e))
        .toList());
  }

  @override
  Future<bool> reportRecruitmentPost(String id, String reason) {
    return postMethod(
      '${ApiUrl.reportRecruitmentPost}/$id',
      body: {ApiParameter.reason: reason},
    ).then((res) => true);
  }

  @override
  Future<bool> saveRecruitmentPosts(String id) {
    return postMethod(
      '${ApiUrl.saveRecruitmentPosts}/$id',
    ).then((res) => true);
  }

  @override
  Future<bool> unSaveRecruitmentPosts(String id) {
    return deleteMethod('${ApiUrl.unSaveRecruitmentPosts}/$id')
        .then((value) => true);
  }
}
