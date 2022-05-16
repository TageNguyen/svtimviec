import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_services.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/list_candidates/list_candidates_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/list_candidates/list_candidates_screen.dart';

class ListCandidatesPage extends StatelessWidget {
  final RecruitmentPost post;
  const ListCandidatesPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecruiterServices>(create: (context) => RecruiterServices()),
        ProxyProvider<RecruiterServices, ListCandidatesBloC>(
          update: (context, recruitmentApi, previous) =>
              previous ?? ListCandidatesBloC(recruitmentApi, post),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: const ListCandidatesScreen(),
    );
  }
}
