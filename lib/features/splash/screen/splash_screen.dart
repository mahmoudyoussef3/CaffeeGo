import 'dart:async';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Onboarding/screens/onboarding_screen.dart';

class SharedPrefsHelper {
  static Future<void> saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
                opacity: 0.5,
                child: Image.asset(
                    'assets/onboarding_imgs/unsplash_SCbq6uKCyMY.png')),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Image.asset('assets/onboarding_imgs/coffeescript logo.png'),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      if (await getBool()) {
                        if (FirebaseAuth.instance.currentUser?.uid != null) {
                          Navigator.pushReplacementNamed(
                              context, AppStrings.home);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, AppStrings.login);
                        }
                      } else {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const OnboardingScreen();
                          },
                        ));
                      }
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 3 / 4,
                      decoration: BoxDecoration(
                        color: const Color(0xffCE9760),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: AppColors.secondaryBrownAppColor,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future<bool> getBool() async {
    return await SharedPrefsHelper.getBool(AppStrings.introPagesViewed) ??
        false;
  }
}
