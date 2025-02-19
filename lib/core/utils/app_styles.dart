import 'package:flutter/material.dart';

class AppTextStyles {
  static const double text28Size = 28;
  static const double text24Size = 24;
  static const double text20Size = 20;
  static const double text18Size = 18;
  static const double text16Size = 16;
  static const double text14Size = 14;
  static const double text12Size = 12;
  static const double text10Size = 10;

  static final TextTheme lightTextTheme = const TextTheme(
    displayLarge: TextStyle(
        fontSize: text28Size, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: TextStyle(
        fontSize: text24Size, fontWeight: FontWeight.w700, color: Colors.black),
    displaySmall: TextStyle(
        fontSize: text20Size, fontWeight: FontWeight.w600, color: Colors.black),
    headlineLarge: TextStyle(
        fontSize: text18Size, fontWeight: FontWeight.w500, color: Colors.black),
    headlineMedium: TextStyle(
        fontSize: text16Size, fontWeight: FontWeight.w400, color: Colors.black),
    headlineSmall: TextStyle(
        fontSize: text14Size, fontWeight: FontWeight.w300, color: Colors.black),
    titleLarge: TextStyle(
        fontSize: text12Size, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: TextStyle(
        fontSize: text10Size, fontWeight: FontWeight.w400, color: Colors.black),
    bodyLarge: TextStyle(fontSize: text16Size, color: Colors.black),
    bodyMedium: TextStyle(fontSize: text14Size, color: Colors.black),
    bodySmall: TextStyle(fontSize: text12Size, color: Colors.black),
    labelLarge: TextStyle(
        fontSize: text12Size, fontWeight: FontWeight.bold, color: Colors.black),
    labelMedium: TextStyle(
        fontSize: text10Size, fontWeight: FontWeight.w400, color: Colors.black),
  );

  static final TextTheme darkTextTheme = const TextTheme(
    displayLarge: TextStyle(
        fontSize: text28Size, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(
        fontSize: text24Size, fontWeight: FontWeight.w700, color: Colors.white),
    displaySmall: TextStyle(
        fontSize: text20Size, fontWeight: FontWeight.w600, color: Colors.white),
    headlineLarge: TextStyle(
        fontSize: text18Size, fontWeight: FontWeight.w500, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: text16Size, fontWeight: FontWeight.w400, color: Colors.white),
    headlineSmall: TextStyle(
        fontSize: text14Size, fontWeight: FontWeight.w300, color: Colors.white),
    titleLarge: TextStyle(
        fontSize: text12Size, fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: TextStyle(
        fontSize: text10Size, fontWeight: FontWeight.w400, color: Colors.white),
    bodyLarge: TextStyle(fontSize: text16Size, color: Colors.white),
    bodyMedium: TextStyle(fontSize: text14Size, color: Colors.white),
    bodySmall: TextStyle(fontSize: text12Size, color: Colors.white),
    labelLarge: TextStyle(
        fontSize: text12Size, fontWeight: FontWeight.bold, color: Colors.white),
    labelMedium: TextStyle(
        fontSize: text10Size, fontWeight: FontWeight.w400, color: Colors.white),
  );
}
