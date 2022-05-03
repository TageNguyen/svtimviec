class Province {
  late int id;
  late String name;

  Province.fromJson(Map<String, dynamic> json) {
    id = json['ProvinceID'];
    name = json['ProvinceName'];
  }
}
