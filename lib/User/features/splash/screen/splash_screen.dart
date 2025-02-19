import 'dart:async';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Onboarding/screens/onboarding_screen.dart';
import '../shared_pref_helper.dart';

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
                    fit: BoxFit.cover,
                    'assets/onboarding_imgs/unsplash_SCbq6uKCyMY.png')),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Image.asset('assets/onboarding_imgs/coffeescript logo.png'),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      bool? isUserSignedIn = await SharedPrefsHelper.getBool(
                              AppStrings.introPagesViewed) ??
                          false;
                      if (isUserSignedIn) {
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.pushReplacementNamed(
                              context, AppStrings.managerScreen);
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
                      height: 60.h,
                      width: MediaQuery.of(context).size.width * 3 / 4.w,
                      decoration: BoxDecoration(
                        color: const Color(0xffCE9760),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          'Get Started',
                          style: TextStyle(
                              color: AppColors.secondaryBrownAppColor,
                              fontSize: 26.sp,
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
}
