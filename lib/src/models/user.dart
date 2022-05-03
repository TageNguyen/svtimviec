import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';

/// User data
class User {
  late int id;
  int? recruiterId;
  int? studentId;
  String? email;
  String? name;
  String? avatar;
  TypeRole? role;
  String? verifyCode;
  Gender? gender;
  int? age;
  String? phone;
  String? address;
  int? provinceId;
  String? companyName;
  String? companyImage;
  String? companyAddress;
  String? website;
  bool? isBlock;

  User(
      {required this.id,
      this.recruiterId,
      this.studentId,
      this.email,
      this.name,
      this.avatar,
      this.role,
      this.verifyCode,
      this.gender,
      this.age,
      this.phone,
      this.address,
      this.provinceId,
      this.companyName,
      this.companyImage,
      this.companyAddress,
      this.website,
      this.isBlock});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? json['user_id'] ?? '';
    recruiterId = json['recruiter_id'];
    studentId = json['student_id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    role = TypeRoleEX.fromIndex(json['role']);
    verifyCode = json['verify_code'];
    gender = GenderEX.fromIndex(json['sex']);
    age = json['age'];
    phone = json['phone'];
    address = json['address'];
    provinceId = json['province_id'];
    companyName = json['company_name'];
    companyImage = json['company_image'];
    companyAddress = json['company_address'];
    website = json['website'];
    isBlock = json['is_block'] == true;
  }
}
