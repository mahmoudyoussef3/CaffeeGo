import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CoffeeCardShimmer extends StatelessWidget {
  const CoffeeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColorsDarkTheme.greyAppColor,
      highlightColor: AppColorsDarkTheme.greyLessDegreeAppColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 128,
              decoration: BoxDecoration(
                color: AppColorsDarkTheme.greyAppColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 20,
              width: double.infinity,
              color: AppColorsDarkTheme.greyAppColor,
            ),
            const SizedBox(height: 8),
            Container(
              height: 20,
              width: 150,
              color: AppColorsDarkTheme.greyAppColor,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 50,
                  color: AppColorsDarkTheme.greyAppColor,
                ),
                const Spacer(),
                Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AppColorsDarkTheme.greyAppColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
