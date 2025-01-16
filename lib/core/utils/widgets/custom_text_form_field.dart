// import 'package:coffe_app/core/utils/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CustomTextFormField extends StatelessWidget {
//   const CustomTextFormField({
//     super.key,
//     required this.controller,
//     required this.labelText,
//     required this.icon,
//     required this.hintText,
//
//     this.obscureText = false,
//     this.keyboardType = TextInputType.text,
//   });
//
//   final TextEditingController controller;
//   final String labelText;
//   final IconData icon;
//   final String hintText;
//   final bool obscureText;
//
//   final TextInputType keyboardType;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Field is required';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: AppColors.brownAppColor),
//         labelText: labelText,
//         labelStyle: TextStyle(
//           fontSize: 16,
//           color: Colors.grey[600],
//         ),
//         hintText: hintText,
//         hintStyle: TextStyle(
//           fontSize: 14,
//           color: Colors.grey[400],
//         ),
//         filled: true,
//         fillColor: Colors.grey[200],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//       ),
//     );
//   }
// }
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return 'Field is required';
              }
              return null;
            },
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.brownAppColor),
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
          ),
          filled: true,
          fillColor: const Color(0xff16181C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(
            color: Colors.red[600],
            fontSize: 12,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }
}
