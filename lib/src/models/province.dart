class Province {
  late int id;
  late String name;

  Province({required this.id, required this.name});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['ProvinceID'];
    name = json['ProvinceName'];
  }
}
