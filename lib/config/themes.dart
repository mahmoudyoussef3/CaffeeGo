import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: AppColorsDarkTheme.darkBlueAppColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    bodySmall: TextStyle(
        fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColorsDarkTheme.darkBlueAppColor,
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
);
