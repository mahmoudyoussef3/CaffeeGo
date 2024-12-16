import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 73,
      width: 345,
      decoration: BoxDecoration(
        color: AppColors.secondaryBrownAppColor,
        borderRadius: BorderRadius.circular(34),
      ),
      child: const Center(
        child: Row(
          children: [
            Text("Add To Cart",style: TextStyle(color: Colors.white,fontSize: 16)),
            Spacer(),
            Text("|",style: TextStyle(color: Colors.white,fontSize: 16),),
            Spacer(),
            Text("12 \$",style: TextStyle(color: Colors.white,fontSize: 16),),


          ],
        ),
      ),
    );
  }
}
