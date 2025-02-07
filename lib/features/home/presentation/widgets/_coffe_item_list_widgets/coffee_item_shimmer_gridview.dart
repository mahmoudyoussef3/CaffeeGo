import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'coffee_card_shimmer.dart';

class CoffeeItemShimmerGridview extends StatelessWidget {
  const CoffeeItemShimmerGridview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.h),
      child: SizedBox(
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              childAspectRatio: 0.68,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return CoffeeCardShimmer();
            }),
      ),
    );
  }
}
