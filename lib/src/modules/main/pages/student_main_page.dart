import 'package:flutter/material.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/modules/main/widgets/search_bar.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class StudentMainPage extends StatelessWidget {
  const StudentMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildBackgroundImage(context),
          _buildScrollableBody(context),
        ],
      ),
    );
  }

  Widget _buildScrollableBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverAppBar(context),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                height: 100,
                child: Text('Item: $index'),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.topCenter,
      child: Image.asset(
        ImagePaths.homeBackGround,
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
      bottom: const PreferredSize(
        child: SearchBar(),
        preferredSize: Size.fromHeight(60.0),
      ),
    );
  }
}
