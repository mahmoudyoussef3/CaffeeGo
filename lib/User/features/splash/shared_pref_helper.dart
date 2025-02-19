import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static Future<void> saveBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print(prefs.getBool(AppStrings.introPagesViewed));
    }
    await prefs.setBool(key, true);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (kDebugMode) {
      print("this is ${prefs.getBool(AppStrings.introPagesViewed)}");
    }
    return prefs.getBool(key);
  }
}
