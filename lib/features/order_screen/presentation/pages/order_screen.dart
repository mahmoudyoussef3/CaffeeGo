
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../widgets/order_item.dart';
import '../widgets/toggle_buttons.dart';

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
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ToggleButtonsWidget(),
              SizedBox(height: 24,),
              Divider(thickness: 1,color: AppColors.offWhiteAppColor,
                endIndent: 30,
                indent: 30,),
              SizedBox(height: 24,),
              CustomOrderItme(),


            ],
          ),
        ),
      ),
    );

  }
}
