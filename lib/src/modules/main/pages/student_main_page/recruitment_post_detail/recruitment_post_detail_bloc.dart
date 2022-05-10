import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/api/recruitment_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class RecruitmentPostDetailBloC extends BloC {
  final RecruitmentApi recruitmentApi;
  final RecruitmentPost recruitmentPost;

  RecruitmentPostDetailBloC(this.recruitmentApi, this.recruitmentPost);

  // store recruitment post detail
  final _recruitmentObject = BehaviorSubject<RecruitmentPost>();
  Stream<RecruitmentPost> get recruitmentDetail => _recruitmentObject.stream;

  // manage apply button state (applied or not)
  final _applyButtonObject = BehaviorSubject<bool>();
  Stream<bool> get applyButtonState => _applyButtonObject.stream;

  // manage save button state (saved or not)
  final _saveButtonObject = BehaviorSubject<bool>();
  Stream<bool> get saveButtonState => _saveButtonObject.stream;

  // manage comment field state (can post or not)
  final _commentFieldObject = BehaviorSubject<bool>();
  Stream<bool> get canPostCommentState => _commentFieldObject.stream;

  String _comment = '';

  set comment(String value) => _comment = value.trim();

  /// get recruitment post detail
  Future<void> getRecruitmentDetail() async {
    RecruitmentPost post =
        await recruitmentApi.getRecruitmentPostDetail(recruitmentPost.id);
    _recruitmentObject.add(post);
    _applyButtonObject.add(post.isApplied);
    _saveButtonObject.add(post.isSaved);
    _commentFieldObject.add(!post.isReported);
  }

  Future<void> applyForRecruitmentPost() async {
    await recruitmentApi.applyForRecruitmentPost(recruitmentPost.id);
    _applyButtonObject.add(true);
  }

  Future<void> saveRecruitmentPost() async {
    await recruitmentApi.saveRecruitmentPost(recruitmentPost.id);
    _saveButtonObject.add(true);
  }

  Future<void> unSaveRecruitmentPost() async {
    await recruitmentApi.unSaveRecruitmentPost(recruitmentPost.id);
    _saveButtonObject.add(false);
  }

  Future<void> commentPost() async {
    await recruitmentApi.reportRecruitmentPost(recruitmentPost.id, _comment);
    _comment = '';
    _commentFieldObject.add(false);
    getRecruitmentDetail();
  }

  @override
  void dispose() {
    _recruitmentObject.close();
    _applyButtonObject.close();
    _saveButtonObject.close();
    _commentFieldObject.close();
  }
}
