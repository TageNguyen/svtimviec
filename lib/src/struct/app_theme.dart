import 'package:flutter/material.dart';
import 'package:student_job_applying/src/constants.dart';
import 'package:student_job_applying/src/utils/app_style/app_colors.dart';
import 'package:student_job_applying/src/utils/app_style/app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
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
    elevatedButtonTheme: elevatedButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
    textButtonTheme: textButtonThemeData,
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
    elevatedButtonTheme: elevatedButtonThemeData,
    inputDecorationTheme: inputDecorationTheme,
    textButtonTheme: textButtonThemeData,
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

  static ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: AppColors.darkBlue,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      textStyle: AppTextStyles.whiteBold.copyWith(fontSize: 18),
    ),
  );

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    labelStyle: AppTextStyles.defaultRegular,
    hintStyle: AppTextStyles.defaultRegular.copyWith(color: AppColors.grey),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    filled: true,
    isDense: true,
    fillColor: AppColors.darkBlue.withOpacity(0.2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(36.0),
      borderSide: BorderSide.none,
    ),
  );

  static TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0.0,
      backgroundColor: AppColors.noColor,
      splashFactory: NoSplash.splashFactory,
      primary: AppColors.darkBlue,
      padding: EdgeInsets.zero,
      textStyle: AppTextStyles.whiteBold.copyWith(color: AppColors.darkBlue),
    ),
  );
}
