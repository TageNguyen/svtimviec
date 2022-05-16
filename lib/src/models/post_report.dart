import 'package:intl/intl.dart';

class PostReport {
  late int id;
  int? studentId;
  int? recruitmentNewId;
  DateTime? createdAt;
  String? updatedAt;
  String comment = '';
  String name = '';
  String avatar = '';

  PostReport(
      {required this.id,
      this.studentId,
      this.recruitmentNewId,
      required this.comment,
      required this.name,
      required this.avatar,
      this.createdAt,
      this.updatedAt});

  PostReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    recruitmentNewId = json['recruitment_new_id'];
    createdAt =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(json['created_at']);
    updatedAt = json['updated_at'];
    comment = json['reason'] ?? '';
    name = json['name'] ?? '';
    avatar = json['avatar'] ?? '';
  }
}
