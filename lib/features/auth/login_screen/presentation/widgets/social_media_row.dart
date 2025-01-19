import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/app_colors.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: const Color(0xff16181C),
          content: Text(
            label,
            style: const TextStyle(color: AppColors.brownAppColor),
          ),
        ));
      },
      child: Container(
        width: 80.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: const Color(0xff16181C),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SocialButton(
            icon: FontAwesomeIcons.facebook,
            label: 'In progress',
          ),
          SocialButton(
            icon: FontAwesomeIcons.google,
            label: 'In progress',
          ),
          SocialButton(
            icon: FontAwesomeIcons.twitter,
            label: 'In progress',
          ),
        ],
      ),
    );
  }
}
