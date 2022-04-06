import 'package:flutter/material.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/utils/app_style/app_colors.dart';
import 'package:student_job_applying/src/utils/app_style/app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.tintLighter,
    platform: TargetPlatform.iOS,
    fontFamily: 'GoogleSans',
    textTheme: TextTheme(
      // used for highlight text
      bodyText1: AppTextStyles.defaultSemibold,
      // used for normal text
      bodyText2: AppTextStyles.defaultRegular,
      // used for the primary text in app bars and dialogs
      headline6: AppTextStyles.defaultSemibold,
      // used for the primary text in lists (e.g., [ListTile.title]).
      subtitle1: AppTextStyles.defaultSemibold,
      // for medium emphasis text that's a little smaller than [subtitle1]
      subtitle2: AppTextStyles.defaultSemibold,
      // used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
      button:
          AppTextStyles.whiteBold.copyWith(fontSize: kDefaultFontSize + 2.0),
    ),
    bottomSheetTheme: bottomSheetTheme,
    dialogTheme: dialogTheme,
    appBarTheme: appBarTheme,
    iconTheme: iconTheme,
    primaryIconTheme: iconTheme,
    backgroundColor: AppColors.tintLighter,
    indicatorColor: AppColors.darkBlue,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black1A,
    platform: TargetPlatform.iOS,
    fontFamily: 'GoogleSans',
    textTheme: TextTheme(
      // used for highlight text
      bodyText1: AppTextStyles.defaultSemibold.copyWith(color: AppColors.white),
      // used for normal text
      bodyText2: AppTextStyles.defaultRegular.copyWith(color: AppColors.white),
      // used for the primary text in app bars and dialogs
      headline6: AppTextStyles.defaultSemibold.copyWith(color: AppColors.white),
      // used for the primary text in lists (e.g., [ListTile.title]).
      subtitle1: AppTextStyles.defaultSemibold.copyWith(color: AppColors.white),
      // for medium emphasis text that's a little smaller than [subtitle1]
      subtitle2: AppTextStyles.defaultSemibold.copyWith(color: AppColors.white),
      // used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
      button:
          AppTextStyles.whiteBold.copyWith(fontSize: kDefaultFontSize + 2.0),
    ),
    bottomSheetTheme:
        bottomSheetTheme.copyWith(backgroundColor: AppColors.black),
    dialogTheme: dialogTheme.copyWith(
      backgroundColor: AppColors.black,
      contentTextStyle:
          AppTextStyles.defaultRegular.copyWith(color: AppColors.white),
      titleTextStyle:
          AppTextStyles.defaultSemibold.copyWith(color: AppColors.white),
    ),
    appBarTheme: appBarTheme.copyWith(
      color: Colors.black,
      titleTextStyle:
          AppTextStyles.defaultSemibold.copyWith(color: AppColors.white),
    ),
    iconTheme: iconTheme.copyWith(color: AppColors.white),
    primaryIconTheme: iconTheme.copyWith(color: AppColors.white),
    backgroundColor: AppColors.black1A,
    indicatorColor: AppColors.black,
  );

  static BottomSheetThemeData bottomSheetTheme = const BottomSheetThemeData(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    ),
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    color: Colors.white,
    titleTextStyle: AppTextStyles.defaultSemibold,
    centerTitle: true,
    elevation: 0,
    iconTheme: iconTheme,
    actionsIconTheme: iconTheme,
  );

  static DialogTheme dialogTheme = const DialogTheme(
    backgroundColor: AppColors.white,
    contentTextStyle: AppTextStyles.defaultRegular,
    titleTextStyle: AppTextStyles.defaultSemibold,
    elevation: 24.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      ),
    ),
  );

  static IconThemeData iconTheme = const IconThemeData(
    color: AppColors.black,
    size: kDefaultIconSize,
  );
}
