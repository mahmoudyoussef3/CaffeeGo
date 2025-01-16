import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/auth/RegisterScreen/presentation/screens/register_screen.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppStrings.introPagesViewed, true);
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontFamily: 'Poppins',
          color: AppColors.offWhiteAppColor),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      bodyTextStyle: TextStyle(
        letterSpacing: 1.5,
        fontSize: 14,
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
        skip: const Text('Skip',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.brownAppColor)),
        next: const Icon(
          Icons.arrow_forward,
          color: AppColors.offWhiteAppColor,
        ),
        done: const Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.brownAppColor)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeColor: AppColors.brownAppColor,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
        autoScrollDuration: 3000,
        infiniteAutoScroll: true,
        pages: [
          PageViewModel(
            footer: const Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 1),
                  Text(
                    'Unlock bean\nsecrets',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.8,
                      fontFamily: 'Poppins',
                      color: AppColors.offWhiteAppColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur.\n Vestibulum eget blandit mattis ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 14,
                      color: AppColors.brownAppColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
            title: '',
            body: '',
            decoration: pageDecoration,
            image: Opacity(
              opacity: 0.4,
              child: Image.asset('assets/onboarding_imgs/onboarding1.png'),
            ),
          ),
          PageViewModel(
            decoration: pageDecoration,
            footer: const Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Text('Flavorful bean\njourney',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.8,
                          fontFamily: 'Poppins',
                          color: AppColors.offWhiteAppColor)),
                  SizedBox(height: 12),
                  Text(
                    textAlign: TextAlign.center,
                    'Lorem ipsum dolor sit amet consectetur.\n Vestibulum eget blandit mattis ',
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 14,
                      color: AppColors.brownAppColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  )
                ],
              ),
            ),
            title: '',
            body: '',
            image: Opacity(
                opacity: 0.4,
                child: Image.asset('assets/onboarding_imgs/onboarding2.png')),
          ),
          PageViewModel(
            footer: Column(
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
                    height: 60,
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    decoration: BoxDecoration(
                      color: const Color(0xffCE9760),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: AppColors.secondaryBrownAppColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.brownAppColor),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: AppColors.brownAppColor,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            decoration: pageDecoration,
            title: '',
            body: '',
            image: Opacity(
                opacity: 0.4,
                child: Image.asset('assets/onboarding_imgs/onboarding3.png')),
          )
        ]);
  }
}
