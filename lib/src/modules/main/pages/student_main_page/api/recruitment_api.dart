import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/struct/api/base_api.dart';

abstract class RecruitmentApi extends BaseApi {
  /// get list recruitment post using paging and filter
  Future<List<RecruitmentPost>> getRecruitmentPosts({
    int page = 1,
    SalaryType? salaryType,
    int? salaryFrom,
    int? salaryTo,
    int? minAge,
    Gender? gender,
    String keyword = '',
  });

  /// get recruitment post detail from [id]
  Future<RecruitmentPost> getRecruitmentPostDetail(String id);

  /// apply for recruitment post
  Future<bool> applyForRecruitmentPost(String id);

  /// report recruitment post
  Future<bool> reportRecruitmentPost(String id, String reason);

  /// save recruitment post
  Future<bool> saveRecruitmentPosts(String id);

  /// remove recruitment post from saved list
  Future<bool> unSaveRecruitmentPosts(String id);

  /// get saved recruitment post list
  Future<List<RecruitmentPost>> getSavedRecruitmentPosts({int page = 1});
}
