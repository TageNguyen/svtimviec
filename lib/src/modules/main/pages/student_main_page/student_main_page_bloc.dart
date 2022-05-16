import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/api/recruitment_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class StudentMainPageBloC extends BloC {
  final RecruitmentApi recruitmentApi;

  StudentMainPageBloC(this.recruitmentApi);

  final _recruitmentPostsObject = BehaviorSubject<List<RecruitmentPost>?>();
  Stream<List<RecruitmentPost>?> get recruitmentPosts =>
      _recruitmentPostsObject.stream;

  int _currentPage = 1;
  bool _canLoadMore = true;

  String _keyword = '';
  Gender? _gender;
  int? _minAge;
  int? _salaryFrom;
  int? _salaryTo;
  SalaryType? _salaryType;
  final List<RecruitmentPost> _currentList = <RecruitmentPost>[];

  set keyword(String value) => _keyword = value.trim();
  set gender(Gender value) => _gender = value;
  set minAge(int value) => _minAge = value;
  set salaryFrom(int value) => _salaryFrom = value;
  set salaryTo(int value) => _salaryTo = value;
  set salaryType(SalaryType value) => _salaryType = value;

  Future<void> getRecruitmentPosts({bool isRefresh = true}) async {
    if (!_canLoadMore && !isRefresh) {
      return;
    }
    if (isRefresh) {
      _currentPage = 1;
      _currentList.clear();
      _recruitmentPostsObject.add(null);
    } else {
      _currentPage++;
    }
    List<RecruitmentPost> recruitmentPosts =
        await recruitmentApi.getRecruitmentPosts(
      page: _currentPage,
      keyword: _keyword,
      gender: _gender,
      minAge: _minAge,
      salaryFrom: _salaryFrom,
      salaryTo: _salaryTo,
      salaryType: _salaryType,
    );
    _canLoadMore = recruitmentPosts.length ==
        kDefaultPageSize; // can not loadmore if api return a list has less element than page size
    _currentList.addAll(recruitmentPosts);
    _recruitmentPostsObject.add(_currentList);
  }

  @override
  void dispose() {
    _recruitmentPostsObject.close();
  }
}
