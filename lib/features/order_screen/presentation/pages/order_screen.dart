
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyAppColor,

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: double.infinity,
          // height: 700,
          child:  Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


              ],
            ),
          ),
        ),
      ),
    );

  }
}
