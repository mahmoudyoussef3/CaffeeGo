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
        children: List.generate(
            3,
            (index) => GestureDetector(
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
                      elevation: 0,
                      color: coffeeSize == index
                          ? AppColors.brownAppColor
                          : Colors.white,
                      child: Container(
                        height: 37,
                        width: 85,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: coffeeSize == index
                                ? AppColors.offWhiteAppColor
                                : Colors.black26,
                          ),
                          color: coffeeSize == index
                              ? AppColors.brownAppColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                            child: Text(
                          coffeeSizeList[index],
                          style: TextStyle(
                              color: coffeeSize == index
                                  ? Colors.white
                                  : Colors.black),
                        )),
                      ),
                    ),
                  ),
                )));
  }

  List<String> coffeeSizeList = [
    "small",
    "medium",
    "large",
  ];
}


