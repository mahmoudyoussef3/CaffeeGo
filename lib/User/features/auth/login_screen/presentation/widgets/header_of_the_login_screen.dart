import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';


class HeaderOfTheLoginScreen extends StatelessWidget {
  const HeaderOfTheLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100.h),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Image.asset(
            'assets/onboarding_imgs/Vector.png',
            // height: 120,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Welcome to Login',
          style: TextStyle(
              color: AppColors.offWhiteAppColor,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
              fontSize: 26.sp,
              fontFamily: 'Poppins'),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
