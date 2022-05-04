import 'package:intl/intl.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/user.dart';

class RecruitmentPost {
  int? id;
  String? jobName;
  String? jobDescription;
  int? status;
  SalaryType? salaryType;
  String? salaryFrom;
  String? salaryTo;
  int? minAge;
  Gender? gender;
  int? recruiterId;
  int? adminId;
  int? jobCategoryId;
  DateTime? createdAt;
  String? updatedAt;
  User? recruiter;

  RecruitmentPost(
      {this.id,
      this.jobName,
      this.jobDescription,
      this.status,
      this.salaryType,
      this.salaryFrom,
      this.salaryTo,
      this.minAge,
      this.gender,
      this.recruiterId,
      this.adminId,
      this.jobCategoryId,
      this.createdAt,
      this.updatedAt,
      this.recruiter});

  RecruitmentPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobName = json['job_name'];
    jobDescription = json['job_description'];
    status = json['status'];
    salaryType = SalaryTypeEX.fromIndex(json['salary_type']);
    salaryFrom = json['salary_from'];
    salaryTo = json['salary_to'];
    minAge = json['min_age'];
    gender = GenderEX.fromIndex(json['sex']);
    recruiterId = json['recruiter_id'];
    adminId = json['admin_id'];
    jobCategoryId = json['job_category_id'];
    createdAt =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(json['created_at']);
    updatedAt = json['updated_at'];
    recruiter =
        json['recruiter'] != null ? User.fromJson(json['recruiter']) : null;
  }
}
