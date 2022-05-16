import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:student_job_applying/src/extensions/exception_ex.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/saved_posts/saved_posts_bloc.dart';
import 'package:student_job_applying/src/modules/main/widgets/recruitment_post_item.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class SavedPostsScreen extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  SavedPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: StreamBuilder<List<RecruitmentPost>?>(
        stream: context.read<SavedPostsBloC>().savedPosts,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return loadingWidget;
          }
          if (snapshot.hasError) {
            return errorScreen(message: (snapshot.error as Exception).message);
          }
          List<RecruitmentPost> posts = snapshot.data!;
          if (posts.isEmpty) {
            return emptyMessage;
          }
          return _buildListSavedPosts(context, posts);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.savedRecruitmentPosts),
    );
  }

  Widget _buildListSavedPosts(
      BuildContext context, List<RecruitmentPost> posts) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) =>
          _onScrollNotification(context, notification),
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () => _onRefresh(context),
        header: const MaterialClassicHeader(),
        child: ListView.builder(
          itemCount: posts.length,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          itemBuilder: (_, index) {
            return RecruitmentPostItem(recruitmentPost: posts[index]);
          },
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) async {
    context.read<SavedPostsBloC>().getSavedPosts();
    _refreshController.refreshCompleted();
  }

  _onScrollNotification(BuildContext context, ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;
      if (before == max) {
        // load next page
        // code here will be called only if scrolled to the very bottom
        context.read<SavedPostsBloC>().getSavedPosts(isRefresh: false);
      }
    }
    return false;
  }
}
