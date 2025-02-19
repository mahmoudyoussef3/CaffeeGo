import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';

class DoNotHaveAnAccount extends StatelessWidget {
  const DoNotHaveAnAccount({super.key});


  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          "Don't have an account ? ",
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
            Navigator.pushNamed(context, AppStrings.signup);
          },
          child:  Text(
            'Register',
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
