import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/api/recruitment_services.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/saved_posts/saved_posts_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/saved_posts/saved_posts_screen.dart';

class SavedPostsPage extends StatelessWidget {
  const SavedPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecruitmentServices>(
          create: (context) => RecruitmentServices(),
        ),
        ProxyProvider<RecruitmentServices, SavedPostsBloC>(
          update: (context, recruitmentApi, previous) =>
              previous ?? SavedPostsBloC(recruitmentApi),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: SavedPostsScreen(),
    );
  }
}
