import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CoffeeSizeItems extends StatefulWidget {
  const CoffeeSizeItems({super.key});

  @override
  State<CoffeeSizeItems> createState() => _CoffeeSizeItemsState();
}

class _CoffeeSizeItemsState extends State<CoffeeSizeItems> {
  int coffeeSize = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: List.generate(3,
                (index) =>  InkWell(
              onTap: () {

                setState(() {
                  coffeeSize = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  elevation: 10,
                  color: coffeeSize == index ? AppColors.secondaryBrownAppColor : Colors.white,
                  child: Container(
                    height: 37,
                    width:  95,
                    decoration: BoxDecoration(
                      color: coffeeSize == index ? AppColors.secondaryBrownAppColor : Colors.white,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(child: Text(coffeeSizeList[index],style: TextStyle(color:coffeeSize == index ? Colors.white:Colors.black),)),
                  ),
                ),
              ),
            )));

  }
  List<String> coffeeSizeList = [
    "Small",
    "Medium",
    "Large",
  ];
}
