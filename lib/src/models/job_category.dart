class JobCategory {
  int? id;
  String name = '';
  String description = '';
  bool ispublic = false;

  JobCategory({this.id, this.name = '', this.description = ''});

  JobCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    ispublic = json['is_publised'] == 1;
  }
  bool isEnoughInformations() {
    return name.isNotEmpty && description.isNotEmpty;
  }
}
