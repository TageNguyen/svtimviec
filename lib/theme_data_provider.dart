import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_job_applying/src/struct/app_theme.dart';
import 'package:student_job_applying/src/struct/base_bloc.dart';
import 'package:student_job_applying/src/struct/storage/app_shared_preferences.dart';

class ThemeDataProvider extends BloC {
  ThemeDataProvider() {
    _initialize();
  }

  final _themeObject = BehaviorSubject<ThemeData>();
  Stream<ThemeData> get themeStream => _themeObject.stream;

  late bool _isUseDarkTheme;
  late ThemeData _themeData;

  void _initialize() async {
    _isUseDarkTheme = await AppSharedPreferences.getUseDarkTheme();
    _themeData = _isUseDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    _themeObject.add(_themeData);
  }

  void switchTheme() {
    _isUseDarkTheme = !_isUseDarkTheme;
    AppSharedPreferences.setUseDarkTheme(_isUseDarkTheme);
    _themeData = _isUseDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme;
    _themeObject.add(_themeData);
  }

  @override
  void dispose() {
    _themeObject.close();
  }
}
