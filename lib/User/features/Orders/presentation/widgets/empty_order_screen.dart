import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class EmptyOrderScreen extends StatelessWidget {
  const EmptyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.coffee,
            size: 100,
            color: AppColors.brownAppColor,
          ),
          SizedBox(height: 20),
          Text(
            'You haven`t orders!',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.brownAppColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Enjoy with our drinks',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
