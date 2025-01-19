import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_colors.dart';

class BuildAuthButton extends StatefulWidget {
  const BuildAuthButton(
      {super.key, required this.buttonText, required this.onPressed});
  final String buttonText;
  final VoidCallback onPressed;

  @override
  State<BuildAuthButton> createState() => _BuildAuthButtonState();
}

class _BuildAuthButtonState extends State<BuildAuthButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brownAppColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding:  EdgeInsets.symmetric(vertical: 16.h),
          minimumSize:  Size(double.infinity, 50.h),
        ),
        child: Text(
          widget.buttonText,
          style:  TextStyle(
            letterSpacing: 1,
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
