import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/filter_model.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/api/recruitment_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class StudentMainPageBloC extends BloC {
  final RecruitmentApi recruitmentApi;

  StudentMainPageBloC(this.recruitmentApi);

  // store recruitment posts
  final _recruitmentPostsObject = BehaviorSubject<List<RecruitmentPost>?>();
  Stream<List<RecruitmentPost>?> get recruitmentPosts =>
      _recruitmentPostsObject.stream;

  // store chosen filters
  final _chosenFilterObjects = BehaviorSubject<List<FilterModel>>.seeded([]);
  Stream<List<FilterModel>> get chosenFilters => _chosenFilterObjects.stream;

  int _currentPage = 1;
  bool _canLoadMore = true;

  String _keyword = '';
  Gender? _gender;
  int? _minAge;
  int? _salaryFrom;
  SalaryType? _salaryType;
  final List<RecruitmentPost> _currentList = <RecruitmentPost>[];

  set keyword(String value) => _keyword = value.trim();

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
      salaryTo: null,
      salaryType: _salaryType,
    );
    _canLoadMore = recruitmentPosts.length ==
        kDefaultPageSize; // can not loadmore if api return a list has less element than page size
    _currentList.addAll(recruitmentPosts);
    _recruitmentPostsObject.add(_currentList);
  }

  void applyFilter() {
    List<FilterModel> chosenFilter = _chosenFilterObjects.value.toList();
    bool isRequiredMale =
        chosenFilter.any((element) => element.title == AppStrings.male);
    bool isRequiredFemale =
        chosenFilter.any((element) => element.title == AppStrings.female);
    bool isRequiredWageSalary =
        chosenFilter.any((element) => element.title == AppStrings.wageSalary);
    bool isRequiredAgeGreaterThanTwenty = chosenFilter
        .any((element) => element.title == AppStrings.ageGreaterThanTwenty);
    bool isRequiredSalaryGreaterThanThreeMillions = chosenFilter.any(
      (element) => element.title == AppStrings.salaryGreaterThanThreeMillions,
    );
    // gender
    if (isRequiredFemale && isRequiredMale) {
      _gender = Gender.unknown;
    } else if (isRequiredMale) {
      _gender = Gender.male;
    } else if (isRequiredFemale) {
      _gender = Gender.female;
    } else {
      _gender = null;
    }
    // salary type
    if (isRequiredWageSalary) {
      _salaryType = SalaryType.wage;
    } else {
      _salaryType = null;
    }
    // age
    if (isRequiredAgeGreaterThanTwenty) {
      _minAge = 20;
    } else {
      _minAge = null;
    }
    // salary from
    if (isRequiredSalaryGreaterThanThreeMillions) {
      _salaryFrom = 3000000;
    } else {
      _salaryFrom = null;
    }
    getRecruitmentPosts(isRefresh: true);
  }

  void choseFilter(FilterModel filter) {
    List<FilterModel> chosenFilter = _chosenFilterObjects.value.toList();
    if (filter.title == AppStrings.wageSalary ||
        filter.title == AppStrings.salaryGreaterThanThreeMillions) {
      if (filter.title == AppStrings.wageSalary) {
        chosenFilter.removeWhere((element) =>
            element.title == AppStrings.salaryGreaterThanThreeMillions);
      } else {
        chosenFilter
            .removeWhere((element) => element.title == AppStrings.wageSalary);
        _salaryType = SalaryType.fixed;
      }
    }

    _chosenFilterObjects.add(chosenFilter..add(filter));
  }

  void removeFilter(FilterModel filter) {
    _chosenFilterObjects.add(_chosenFilterObjects.value
      ..removeWhere((element) => element.title == filter.title));
  }

  @override
  void dispose() {
    _recruitmentPostsObject.close();
    _chosenFilterObjects.close();
  }
}
