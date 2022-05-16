import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class RecruiterMainPageBloC extends BloC {
  final RecruiterApi recruiterApi;

  RecruiterMainPageBloC(this.recruiterApi);

  final _recruitmentPostsObject = BehaviorSubject<List<RecruitmentPost>?>();
  Stream<List<RecruitmentPost>?> get recruitmentPosts =>
      _recruitmentPostsObject.stream;

  int _currentPage = 1;
  bool _canLoadMore = true;

  final List<RecruitmentPost> _currentList = <RecruitmentPost>[];

  Future<void> getPostsHistory({bool isRefresh = true}) async {
    if (!_canLoadMore && !isRefresh) {
      return;
    }
    if (isRefresh) {
      _currentPage = 1;
      _currentList.clear();
    } else {
      _currentPage++;
    }
    List<RecruitmentPost> recruitmentPosts =
        await recruiterApi.getPostsHistory(_currentPage);
    _canLoadMore = recruitmentPosts.length ==
        kDefaultPageSize; // can not loadmore if api return a list has less element than page size
    _currentList.addAll(recruitmentPosts);
    _recruitmentPostsObject.add(_currentList);
  }

  /// delete post has [postId]
  void deletePost(int postId) {
    _currentList.removeWhere((element) => element.id == postId);
    _recruitmentPostsObject.add(_currentList);
  }

  /// update post data in list
  void updatePost(RecruitmentPost post) {
    int position = _currentList.indexWhere((element) => element.id == post.id);
    if (position == -1) {
      return;
    }
    _currentList[position] = post;
    _recruitmentPostsObject.add(_currentList);
  }

  @override
  void dispose() {
    _recruitmentPostsObject.close();
  }
}
