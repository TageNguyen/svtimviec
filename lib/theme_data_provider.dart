import 'package:flutter/material.dart';
import 'package:student_job_applying/src/struct/app_theme.dart';
import 'package:student_job_applying/src/struct/storage/app_shared_preferences.dart';

class ThemeDataProvider extends ChangeNotifier {
  ThemeDataProvider() {
    _initialize();
  }

  late bool _isUseDarkTheme;
  ThemeData _themeData = AppTheme.lightTheme;
  ThemeData get themeData => _themeData;

  void _initialize() async {
    _isUseDarkTheme = await AppSharedPreferences.getUseDarkTheme();
    _themeData = _isUseDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }

  void switchTheme() {
    _isUseDarkTheme = !_isUseDarkTheme;
    AppSharedPreferences.setUseDarkTheme(_isUseDarkTheme);
    _themeData = _isUseDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    notifyListeners();
  }
}
