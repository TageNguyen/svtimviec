import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/api/recruitment_services.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/recruitment_post_detail/recruitment_post_detail_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/recruitment_post_detail/recruitment_post_detail_screen.dart';

class RecruitmentPostDetailPage extends StatelessWidget {
  final RecruitmentPost recruitmentPost;
  const RecruitmentPostDetailPage({Key? key, required this.recruitmentPost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecruitmentServices>(
          create: (context) => RecruitmentServices(),
        ),
        ProxyProvider<RecruitmentServices, RecruitmentPostDetailBloC>(
          update: (context, recruitmentApi, previous) =>
              previous ??
              RecruitmentPostDetailBloC(recruitmentApi, recruitmentPost),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const RecruitmentPostDetailScreen(),
    );
  }
}
