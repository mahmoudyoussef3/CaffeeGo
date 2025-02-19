import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../core/utils/app_colors.dart';

class CategoriesContainerShimmer extends StatelessWidget {
  const CategoriesContainerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Shimmer.fromColors(
            baseColor: AppColorsDarkTheme.greyAppColor,
            highlightColor: AppColorsDarkTheme.greyLessDegreeAppColor,
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: AppColorsDarkTheme.greyAppColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      }),
    );
  }
}
