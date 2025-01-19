import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          "Already have an account ? ",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            fontFamily: 'Poppins',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppStrings.login);
          },
          child:  Text(
            'Login',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.brownAppColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}
