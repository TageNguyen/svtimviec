import 'package:flutter/material.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/utils/app_style/app_colors.dart';

// this class constains text style used in whole app
class AppTextStyles {
  static const defaultSemibold = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w600,
    fontSize: kDefaultFontSize,
  );
  static const defaultRegular = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: kDefaultFontSize,
  );
  static const whiteBold = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: kDefaultFontSize,
  );
  static const greyRegular = TextStyle(
    color: AppColors.grey,
    fontWeight: FontWeight.w400,
    fontSize: kDefaultFontSize,
  );
  static const defaultMedium = TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: kDefaultFontSize,
  );
}
