import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomAuthButton extends StatelessWidget {
   CustomAuthButton({super.key,required this.buttonText,required this.onPressed});
   void Function()? onPressed;
   String buttonText;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.brownAppColor)),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
            color: AppColors.offWhiteAppColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 2),
      ),
    );
  }
}
