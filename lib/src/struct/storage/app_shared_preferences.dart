import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';

class AppSharedPreferences {
  AppSharedPreferences._();

  static const String keyAccessToken = 'keyAccessToken';
  static const String keyUseDarkTheme = 'keyUseDarkTheme';
  static const String keyTypeRole = 'keyTypeRole';

  static Future<bool> setAccessToken(String? accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (accessToken == null) {
      return await prefs.remove(keyAccessToken);
    }
    return await prefs.setString(keyAccessToken, accessToken);
  }

  static Future<bool> setUseDarkTheme(bool isUseDarkTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(keyUseDarkTheme, isUseDarkTheme);
  }

  static Future<bool> setTypeRole(TypeRole? typeRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (typeRole == null) {
      return await prefs.remove(keyTypeRole);
    }
    return await prefs.setString(keyTypeRole, typeRole.rawData);
  }

  static Future<bool> getUseDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyUseDarkTheme) ?? false;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAccessToken);
  }

  static Future<TypeRole?> getTypeRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return TypeRoleEX.fromRawData(prefs.getString(keyTypeRole));
  }
}
