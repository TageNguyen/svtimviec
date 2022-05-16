import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/models/request_models/required_informations_request_model.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_api.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/api/profile_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class MyProfileBloC extends BloC {
  final ProfileApi profileApi;
  final AuthApi authApi;

  MyProfileBloC(this.profileApi, this.authApi);

  // store file avatar
  final _avatarObject = BehaviorSubject<File>();
  Stream<File> get avatarStream => _avatarObject.stream;

  // store company file image
  final _companyImageObject = BehaviorSubject<File>();
  Stream<File> get companyImageStream => _companyImageObject.stream;

  StudentRequiredInformationsRequestModel studentRequestModel =
      StudentRequiredInformationsRequestModel();

  RecruiterRequiredInformationsRequestModel recruiterRequestModel =
      RecruiterRequiredInformationsRequestModel();

  set avatar(File file) {
    _avatarObject.add(file);
    studentRequestModel.avatar = file;
    recruiterRequestModel.avatar = file;
  }

  set companyImage(File file) {
    _companyImageObject.add(file);
    recruiterRequestModel.companyImage = file;
  }

  /// update user informations
  Future<void> updateUserInformations() async {
    return profileApi.updateUserInformations(
        UserManager.typeRole == TypeRole.student
            ? studentRequestModel
            : recruiterRequestModel);
  }

  /// get user informations
  Future<User> getCurrentUserInformations() {
    return authApi.getCurrentUserInformations();
  }

  @override
  void dispose() {
    _avatarObject.close();
    _companyImageObject.close();
  }
}
