import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class RecruiterProfileBloC extends BloC {
  final ProfileApi profileApi;
  final int recruiterId;

  RecruiterProfileBloC(this.profileApi, this.recruiterId) {
    getRecruitmentProfile().catchError((error) {
      _recruiterObject.addError(error);
    });
  }

  // store recruiter informations
  final _recruiterObject = BehaviorSubject<User>();
  Stream<User> get recruiterInformations => _recruiterObject.stream;

  /// get recruiter profile via [recruiterId]
  Future<User> getRecruitmentProfile() async {
    User recruiterData = await profileApi.getRecruiterInformations(recruiterId);
    _recruiterObject.add(recruiterData);
    return recruiterData;
  }

  @override
  void dispose() {
    _recruiterObject.close();
  }
}
