import 'package:flutter/material.dart';
import 'package:student_job_applying/src/utils/utils.dart';

extension GenerateRoute on RouteSettings {
  MaterialPageRoute<MaterialPageRoute<dynamic>> get generateRoute {
    switch (name) {
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: const Center(
              child: Text(
                AppStrings.pageNotFound,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
    }
  }
}
