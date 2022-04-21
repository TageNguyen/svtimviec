class LoginResponseModel {
  String token = '';
  int? userId;

  LoginResponseModel({required this.token, this.userId});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
  }
}
