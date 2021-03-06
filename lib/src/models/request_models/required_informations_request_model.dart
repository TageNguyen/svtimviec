import 'dart:io';

import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/province.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_parameter.dart';

abstract class RequiredInformationsRequestModel {
  Map<String, dynamic> toJson();
  bool isEnoughInformations();
}

class StudentRequiredInformationsRequestModel
    extends RequiredInformationsRequestModel {
  int? age;
  String phone = '';
  String district = '';
  String ward = '';
  String name = '';
  File? avatar;
  Gender? gender;
  Province? province;

  StudentRequiredInformationsRequestModel();

  StudentRequiredInformationsRequestModel.fromUser(User? user) {
    age = user?.age ?? 0;
    phone = user?.phone ?? '';
    name = user?.name ?? '';
    gender = user?.gender ?? Gender.female;
    province = Province(id: user?.provinceId ?? 1, name: '');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ApiParameter.sex: gender?.rawData,
      ApiParameter.age: age,
      ApiParameter.phone: phone,
      ApiParameter.province: province?.name ?? '',
      ApiParameter.provinceId: province?.id ?? '',
      ApiParameter.district: district,
      ApiParameter.ward: ward,
      ApiParameter.avatar: avatar,
      ApiParameter.name: name,
    };
  }

  @override
  bool isEnoughInformations() {
    return gender != null &&
        age != null &&
        province != null &&
        phone.isNotEmpty &&
        district.isNotEmpty &&
        ward.isNotEmpty;
  }
}

class RecruiterRequiredInformationsRequestModel
    extends RequiredInformationsRequestModel {
  String phone = '';
  String companyName = '';
  String name = '';
  String district = '';
  String ward = '';
  String website = '';
  File? companyImage;
  File? avatar;
  Province? province;

  RecruiterRequiredInformationsRequestModel();

  RecruiterRequiredInformationsRequestModel.fromUser(User? user) {
    phone = user?.phone ?? '';
    companyName = user?.companyName ?? '';
    name = user?.name ?? '';
    province = Province(id: user?.provinceId ?? 1, name: '');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ApiParameter.phone: phone,
      ApiParameter.companyName: companyName,
      ApiParameter.companyImage: companyImage,
      ApiParameter.provinceId: province?.id ?? '',
      ApiParameter.province: province?.name ?? '',
      ApiParameter.district: district,
      ApiParameter.ward: ward,
      ApiParameter.avatar: avatar,
      ApiParameter.name: name,
      ApiParameter.website: website,
    };
  }

  @override
  bool isEnoughInformations() {
    return phone.isNotEmpty &&
        companyName.isNotEmpty &&
        companyImage != null &&
        province != null &&
        district.isNotEmpty &&
        ward.isNotEmpty;
  }
}
