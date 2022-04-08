import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/app_root.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/struct/app_theme.dart';
import 'package:student_job_applying/src/struct/routes/route_settings.dart';
import 'package:student_job_applying/theme_data_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiProvider(
    providers: [
      Provider<ThemeDataProvider>(create: (_) => ThemeDataProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData>(
      stream: context.read<ThemeDataProvider>().themeStream,
      builder: (_, snapshot) {
        return MaterialApp(
          title: kAppTitle,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings settings) => settings.generateRoute,
          theme: snapshot.data ?? AppTheme.lightTheme,
          home: MultiProvider(providers: [
            Provider<UserManager>(
              create: (_) => UserManager(),
            ),
          ], child: const AppRoot()),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
