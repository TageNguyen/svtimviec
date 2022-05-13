class JobCategory {
  late int id;
  String name = '';
  String description = '';
  bool ispublic = false;

  JobCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    ispublic = json['is_publised'] ?? '';
  }
}
