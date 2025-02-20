import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/utils/app_colors.dart';
class HeaderOfTheSignupScreen extends StatelessWidget {
  const HeaderOfTheSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
       SizedBox(height: 80.h),
      Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 24.w,
        ),
        child: Image.asset(
          'assets/onboarding_imgs/Vector.png',
        ),
      ),
       SizedBox(height: 20.h),
       Text(
        'Register your Account',
        style: TextStyle(
            color: AppColors.offWhiteAppColor,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w700,
            fontSize: 26.sp,
            fontFamily: 'Poppins'),
      ),
    ],);
  }
}
