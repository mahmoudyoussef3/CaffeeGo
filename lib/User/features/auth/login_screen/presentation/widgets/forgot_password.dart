import 'package:coffe_app/Admin/main_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../core/utils/app_colors.dart';


class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: InkWell(
          onTap: () {
            showToastMsg('In Progress...');
          },
          child: Text('Forgot Password ?',
              textAlign: TextAlign.end,
              style: TextStyle(
                decorationColor: AppColors.brownAppColor,
                color: AppColors.brownAppColor,
                fontSize: 12.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              )),
        ),
      ),
    );
  }
}
