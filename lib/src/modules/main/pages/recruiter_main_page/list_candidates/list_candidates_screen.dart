import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/list_candidates/list_candidates_bloc.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/list_candidates/widgets/candidate_item.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/extensions/exception_ex.dart';

class ListCandidatesScreen extends StatelessWidget {
  const ListCandidatesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ListCandidatesBloC>().getListCandidates();
    return Scaffold(
      appBar: _buildAppBar(context),
      body: FutureBuilder<List<User>>(
        future: context.read<ListCandidatesBloC>().getListCandidates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingWidget;
          }
          if (snapshot.hasError) {
            return errorScreen(message: (snapshot.error as Exception).message);
          }
          List<User> candidates = snapshot.data!;
          if (candidates.isEmpty) {
            return emptyMessage;
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: candidates.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
            itemBuilder: (context, index) {
              return CandidateItem(candidate: candidates[index]);
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(context.read<ListCandidatesBloC>().post.jobName),
    );
  }
}
