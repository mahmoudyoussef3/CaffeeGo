import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomLoadingProgress extends StatelessWidget {
  const CustomLoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppColors.brownAppColor,
    );
  }
}
