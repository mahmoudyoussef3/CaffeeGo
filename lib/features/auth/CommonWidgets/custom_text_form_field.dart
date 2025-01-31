import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
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
    required this.passwordFieldOrNot,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool passwordFieldOrNot;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: widget.controller,
        obscureText: widget.passwordFieldOrNot ? _obscureText : false,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        validator: widget.validator ??
            (value) {
              if (value!.isEmpty) {
                return 'Field is required';
              }
              return null;
            },
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: AppColors.brownAppColor),
          labelText: widget.labelText,
          suffixIcon: widget.passwordFieldOrNot
              ? InkWell(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70,
                  ),
                )
              : null,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            color: Colors.white70,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[400],
          ),
          filled: true,
          fillColor: const Color(0xff16181C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          errorStyle: TextStyle(
            color: Colors.red[600],
            fontSize: 12.sp,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        ),
      ),
    );
  }
}
