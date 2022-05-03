import 'dart:io';

import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/province.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_parameter.dart';

abstract class RequiredInformationsRequestModel {
  Map<String, dynamic> toJson();
  bool isEnoughInformations();
}

class StudentRequiredInformationsRequestModel
    extends RequiredInformationsRequestModel {
  Gender? gender;
  int? age;
  Province? province;
  String phone = '';
  String district = '';
  String ward = '';

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
  File? companyImage;
  Province? province;
  String district = '';
  String ward = '';

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
