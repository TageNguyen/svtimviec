import 'package:intl/intl.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/job_category.dart';
import 'package:student_job_applying/src/models/post_report.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/struct/api/api_util/api_parameter.dart';

class RecruitmentPost {
  int? id;
  String jobName = '';
  String jobDescription = '';
  int? status;
  SalaryType salaryType = SalaryType.fixed;
  double salaryFrom = 0;
  double salaryTo = 0;
  int minAge = 0;
  Gender? gender;
  int? recruiterId;
  int? adminId;
  int? jobCategoryId;
  DateTime? createdAt;
  String? updatedAt;
  User? recruiter;
  List<PostReport>? reports;
  int? savedCount;
  int applicationCount = 0;
  JobCategory? jobCategory;
  bool isSaved = false; // whether user has saved this post or not
  bool isApplied = false; // whether user has applied for this post or not
  bool isReported = false; // whether user has reported this post or not

  RecruitmentPost({
    this.id,
    this.jobName = '',
    this.jobDescription = '',
    this.status,
    this.salaryType = SalaryType.fixed,
    this.salaryFrom = 0,
    this.salaryTo = 0,
    this.minAge = 0,
    this.gender,
    this.recruiterId,
    this.adminId,
    this.jobCategoryId,
    this.createdAt,
    this.updatedAt,
    this.recruiter,
    this.reports,
    this.savedCount = 0,
    this.jobCategory,
    this.applicationCount = 0,
  });

  RecruitmentPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobName = json['job_name'];
    jobDescription = json['job_description'];
    status = json['status'];
    salaryType = SalaryTypeEX.fromIndex(json['salary_type']);
    salaryFrom = double.tryParse(json['salary_from'] ?? '0') ?? 0;
    salaryTo = double.tryParse(json['salary_to'] ?? '0') ?? 0;
    minAge = json['min_age'] ?? 0;
    gender = GenderEX.fromIndex(json['sex']);
    recruiterId = json['recruiter_id'];
    adminId = json['admin_id'];
    jobCategoryId = json['job_category_id'];
    createdAt =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(json['created_at']);
    updatedAt = json['updated_at'];
    applicationCount = json['students_apply_count'] ?? 0;
    if (json['recruiter'] != null) {
      recruiter = User.fromJson(json['recruiter']);
    }
    if (json['report_news'] != null) {
      reports = json['report_news']
          .map<PostReport>((e) => PostReport.fromJson(e))
          .toList();
    }
    if (json['favorite_news'] != null) {
      savedCount = json['favorite_news'].length;
    }
    if (json['is_favorite'] != null) {
      isSaved = json['is_favorite'] == 1;
    }
    if (json['is_applied'] != null) {
      isApplied = json['is_applied'] == 1;
    }
    if (json['is_reported'] != null) {
      isReported = json['is_reported'] == 1;
    }
    if (json['job_category'] != null) {
      jobCategory = JobCategory.fromJson(json['job_category']);
    }
  }

  String minSalary() {
    return NumberFormat.currency(locale: 'vi', symbol: '??').format(salaryFrom);
  }

  String maxSalary() {
    return NumberFormat.currency(locale: 'vi', symbol: '??').format(salaryTo);
  }

  Map<String, dynamic> toJson() {
    return {
      ApiParameter.jobName: jobName,
      ApiParameter.jobDescription: jobDescription,
      ApiParameter.isNewCategory: jobCategory?.id != null ? 0 : 1,
      ApiParameter.jobCategoryId: '${jobCategory?.id ?? ''}',
      ApiParameter.jobCategoryName: jobCategory?.name ?? '',
      ApiParameter.jobCategoryDescription: jobCategory?.description ?? '',
      ApiParameter.salaryType: salaryType.rawData,
      ApiParameter.salaryFrom: '$salaryFrom',
      ApiParameter.salaryTo: '$salaryTo ',
      ApiParameter.minAge: '$minAge ',
      ApiParameter.sex: gender?.rawData ?? '',
    };
  }

  bool isEnoughRequireInformations() {
    return jobName.isNotEmpty && jobDescription.isNotEmpty;
  }
}
