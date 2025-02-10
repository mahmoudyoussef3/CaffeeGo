import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../app_colors.dart';

class CustomLoadingProgress extends StatelessWidget {
  const CustomLoadingProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: AppColors.brownAppColor,
      size: 50,
    ));
  }
}
