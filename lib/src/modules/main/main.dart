import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/main_bloc.dart';
import 'package:student_job_applying/src/modules/main/main_screen.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MainBloC>(create: (context) => MainBloC()),
      ],
      child: const MainScreen(),
    );
  }
}
