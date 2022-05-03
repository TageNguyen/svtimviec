import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/models/province.dart';
import 'package:student_job_applying/src/models/request_models/required_informations_request_model.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/auth/api/auth_api.dart';
import 'package:student_job_applying/src/modules/auth/api/province_api.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';

class UpdateRequiredInformationsBloC extends BloC {
  final AuthApi authApi;
  final ProvinceApi provinceApi;

  UpdateRequiredInformationsBloC(this.authApi, this.provinceApi);

  // manage update button status (enable/disable)
  final _updateButtonObject = BehaviorSubject<bool>();
  Stream<bool> get updateButtonStatusStream => _updateButtonObject.stream;

  // manage company image state
  final _companyImageObject = BehaviorSubject<File>();
  Stream<File> get companyImageStream => _companyImageObject.stream;

  late List<Province> provinces = [];

  StudentRequiredInformationsRequestModel studentRequestModel =
      StudentRequiredInformationsRequestModel();

  RecruiterRequiredInformationsRequestModel recruiterRequestModel =
      RecruiterRequiredInformationsRequestModel();

  set companyImage(File file) {
    _companyImageObject.add(file);
    recruiterRequestModel.companyImage = file;
  }

  Future<void> updateRequiredInformations() async {
    debugPrint('role: ${UserManager.typeRole}');
    return authApi.updateRequiredInformations(
        UserManager.typeRole == TypeRole.student
            ? studentRequestModel
            : recruiterRequestModel);
  }

  Future<void> getProvinces() async {
    provinces = await provinceApi.getListProvinces();
  }

  /// get user informations
  Future<User> getCurrentUserInformations() {
    return authApi.getCurrentUserInformations();
  }

  void updateButtonStatus() {
    _updateButtonObject.add(studentRequestModel.isEnoughInformations() ||
        recruiterRequestModel.isEnoughInformations());
  }

  @override
  void dispose() {
    _updateButtonObject.close();
    _companyImageObject.close();
  }
}
