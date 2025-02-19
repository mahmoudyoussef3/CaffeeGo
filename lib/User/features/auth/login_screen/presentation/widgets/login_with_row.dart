import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';


class LoginWithRow extends StatelessWidget {
  const LoginWithRow({super.key, required this.screen});
  final String screen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Divider(
            color: AppColors.brownAppColor,
            endIndent: 5.w,
          ),
        ),
        Text(
          'Or $screen with',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.brownAppColor,
            indent: 5.w,
          ),
        ),
      ],
    );

  }
}
