import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/screen_arguments/post_detail_arguments.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/api/recruiter_services.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/post_detail/post_detail_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/post_detail/post_detail_screen.dart';

class PostDetailPage extends StatelessWidget {
  final PostDetailArguments arguments;
  const PostDetailPage({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RecruiterServices>(
          create: (context) => RecruiterServices(),
        ),
        ProxyProvider<RecruiterServices, PostDetailBloC>(
          update: (context, recruitmentApi, previous) =>
              previous ?? PostDetailBloC(recruitmentApi, arguments.post),
          dispose: (context, bloC) => bloC.dispose(),
        ),
      ],
      child: PostDetailScreen(
        onDelete: arguments.onDelete,
        onUpdated: arguments.onUpdated,
      ),
    );
  }
}
