import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/api/recruitment_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class SavedPostsBloC extends BloC {
  final RecruitmentApi recruitmentApi;

  SavedPostsBloC(this.recruitmentApi) {
    getSavedPosts().catchError((error) {
      _savedPostsObject.addError(error);
    });
  }

  final _savedPostsObject = BehaviorSubject<List<RecruitmentPost>?>();
  Stream<List<RecruitmentPost>?> get savedPosts => _savedPostsObject.stream;

  int _currentPage = 1;
  bool _canLoadMore = true;
  final List<RecruitmentPost> _currentList = <RecruitmentPost>[];

  Future<void> getSavedPosts({bool isRefresh = true}) async {
    if (!_canLoadMore && !isRefresh) {
      return;
    }
    if (isRefresh) {
      _currentPage = 1;
      _currentList.clear();
      _savedPostsObject.add(null);
    } else {
      _currentPage++;
    }
    List<RecruitmentPost> recruitmentPosts =
        await recruitmentApi.getSavedRecruitmentPosts(page: _currentPage);
    _canLoadMore = recruitmentPosts
        .isNotEmpty; // can not loadmore if api return an empty list
    _currentList.addAll(recruitmentPosts);
    _savedPostsObject.add(_currentList);
  }

  @override
  void dispose() {
    _savedPostsObject.close();
  }
}
