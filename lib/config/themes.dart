import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../core/utils/app_styles.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: AppColors.offWhiteAppColor,
    textTheme: AppTextStyles.lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColorsDarkTheme.darkBlueAppColor,
      type: BottomNavigationBarType.fixed,
    ),
    scaffoldBackgroundColor: AppColorsDarkTheme.darkBlueAppColor,
    textTheme: AppTextStyles.darkTextTheme,
  );
}
