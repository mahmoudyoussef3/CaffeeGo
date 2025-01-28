import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../CommonWidgets/custom_text_form_field.dart';

class RegisterTextFields extends StatelessWidget {
  RegisterTextFields({super.key, required this.fullName, required this.emailController, required this.passwordController, required this.confirmPasswordController});

  final TextEditingController fullName ;
  final TextEditingController emailController ;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(height: 30.h),
        CustomTextFormField(
          controller: fullName,
          labelText: 'Full Name',
          icon: Icons.person,
          hintText: 'Enter your full name',
          validator: (value) => value!.isEmpty ? 'Name is required' : null,
        ),
         SizedBox(height: 12.h),
        CustomTextFormField(
          controller: emailController,
          labelText: 'E-mail Address',
          icon: Icons.email,
          hintText: 'user.example@gmail.com',
          keyboardType: TextInputType.emailAddress,
          validator: (value) => value!.isEmpty ||
                  !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)
              ? 'Enter a valid email'
              : null,
        ),
         SizedBox(height: 12.h),
        CustomTextFormField(
          controller: passwordController,
          labelText: 'Password',
          icon: Icons.lock,
          hintText: 'Enter your password',
          obscureText: true,
          validator: (value) => value!.length < 6
              ? 'Password must be at least 6 characters'
              : null,
        ),
         SizedBox(height: 12.h),
        CustomTextFormField(
          controller: confirmPasswordController,
          labelText: 'Confirm Password',
          icon: Icons.lock,
          hintText: 'Confirm your password',
          obscureText: true,
          validator: (value) => value != passwordController.text
              ? 'Passwords do not match'
              : null,
        ),
         SizedBox(height: 32.h),
      ],
    );
  }
}
