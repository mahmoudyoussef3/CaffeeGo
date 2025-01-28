import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/auth/RegisterScreen/presentation/screens/register_screen.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../splash/shared_pref_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Future<void> _onIntroEnd(context) async {
    try {
      await saveIntroPagesViewed();

      await Navigator.of(context).pushReplacementNamed(AppStrings.login);
    } catch (e) {
      debugPrint('Error navigating to login: $e');
    }
  }

  Future<void> saveIntroPagesViewed() async {
    await SharedPrefsHelper.saveBool(AppStrings.introPagesViewed);
  }

  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        fontFamily: 'Poppins',
        color: AppColors.offWhiteAppColor,
      ),
      bodyPadding: EdgeInsets.symmetric(horizontal: 16.0.w),
      bodyTextStyle: TextStyle(
        letterSpacing: 1.5,
        fontSize: 14.sp,
        color: AppColors.brownAppColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
      pageColor: Colors.transparent,
      fullScreen: true,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.black,
      allowImplicitScrolling: true,
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      skipOrBackFlex: 0,
      nextFlex: 0,
      showNextButton: true,
      showBottomPart: true,
      showSkipButton: true,
      showDoneButton: true,
      back: const Icon(Icons.arrow_back, color: AppColors.offWhiteAppColor),
      skip: const Text(
        'Skip',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.brownAppColor,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: AppColors.offWhiteAppColor,
      ),
      done: const Text(
        'Done',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.brownAppColor,
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(16.r),
      dotsDecorator: DotsDecorator(
        size: Size(10.0.w, 10.0.h),
        color: const Color(0xFFBDBDBD),
        activeColor: AppColors.brownAppColor,
        activeSize: Size(22.0.w, 10.0.h),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
        ),
      ),
      dotsContainerDecorator: ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0.r)),
        ),
      ),
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          footer: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Unlock bean\nsecrets',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                    fontFamily: 'Poppins',
                    color: AppColors.offWhiteAppColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Lorem ipsum dolor sit amet consectetur.\n Vestibulum eget blandit mattis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 12.sp,
                    color: AppColors.brownAppColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          title: '',
          body: '',
          decoration: pageDecoration,
          image: Opacity(
            opacity: 0.5,
            child: Image.asset(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.contain,
                'assets/onboarding_imgs/onboarding1.png'),
          ),
        ),
        PageViewModel(
          footer: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Unlock bean\nsecrets',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.8,
                    fontFamily: 'Poppins',
                    color: AppColors.offWhiteAppColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Lorem ipsum dolor sit amet consectetur.\n Vestibulum eget blandit mattis.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 12.sp,
                    color: AppColors.brownAppColor,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          title: '',
          body: '',
          decoration: pageDecoration,
          image: Opacity(
            opacity: 0.5,
            child: Image.asset(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.contain,
                'assets/onboarding_imgs/onboarding2.png'),
          ),
        ),
        PageViewModel(
          footer: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const RegisterScreen();
                      },
                    ));
                  },
                  child: Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: const Color(0xffCE9760),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: AppColors.secondaryBrownAppColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ));
                  },
                  child: Container(
                    height: 60.h,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.brownAppColor),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: AppColors.brownAppColor,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: pageDecoration,
          title: '',
          body: '',
          image: Opacity(
            opacity: 0.5,
            child: Image.asset(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.contain,
                'assets/onboarding_imgs/onboarding3.png'),
          ),
        ),
      ],
    );
  }
}
