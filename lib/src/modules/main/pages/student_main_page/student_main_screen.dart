import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/student_main_page_bloc.dart';
import 'package:student_job_applying/src/modules/main/widgets/recruitment_post_item.dart';
import 'package:student_job_applying/src/modules/main/widgets/search_bar.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({Key? key}) : super(key: key);

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    context.read<StudentMainPageBloC>().getRecruitmentPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _buildBackgroundImage(context),
            _buildScrollableBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableBody(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) =>
          _onScrollNotification(context, notification),
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () {
          _onRefresh(context);
        },
        header: const MaterialClassicHeader(),
        child: CustomScrollView(
          slivers: [
            _buildSliverAppBar(context),
            _buildRecruitmentPostsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.topCenter,
      child: Image.asset(
        ImagePaths.homeBackGround,
        height: 200,
        fit: BoxFit.fitHeight,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      title: Text(
        kAppTitle,
        style: AppTextStyles.whiteBold.copyWith(fontSize: 20),
      ),
      pinned: true,
      floating: true,
      elevation: 0,
      actions: [
        // Tin đã lưu
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.savedPosts);
          },
          icon: const Icon(
            Icons.bookmark,
            color: AppColors.white,
          ),
          tooltip: AppStrings.savedRecruitmentPosts,
        ),
        // Thông tin người dùng
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.profile);
          },
          icon: _buildUserAvatar(context),
          tooltip: AppStrings.userProfile,
        ),
      ],
      bottom: const PreferredSize(
        child: SearchBar(),
        preferredSize: Size.fromHeight(60.0),
      ),
    );
  }

  Widget _buildRecruitmentPostsList(BuildContext context) {
    return StreamBuilder<List<RecruitmentPost>?>(
      stream: context.read<StudentMainPageBloC>().recruitmentPosts,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const SliverFillRemaining(
            child: loadingWidget,
          );
        }
        List<RecruitmentPost> posts = snapshot.data!;
        if (posts.isEmpty) {
          return const SliverFillRemaining(
            child: emptyMessage,
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return RecruitmentPostItem(recruitmentPost: posts[index]);
              },
              childCount: posts.length,
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.read<UserManager>().currentUser,
      builder: (context, snapshot) {
        User? user = snapshot.data;
        return buildNetworkCircleAvatar(user?.avatar ?? '');
      },
    );
  }

  bool _onScrollNotification(
      BuildContext context, ScrollNotification? notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;
      if (before == max) {
        // load next page
        // code here will be called only if scrolled to the very bottom
        context
            .read<StudentMainPageBloC>()
            .getRecruitmentPosts(isRefresh: false);
      }
    }
    return false;
  }

  void _onRefresh(BuildContext context) async {
    context.read<StudentMainPageBloC>().getRecruitmentPosts();
    _refreshController.refreshCompleted();
  }
}
