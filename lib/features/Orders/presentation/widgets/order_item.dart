import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import 'custom_circular_button.dart';

class CustomOrderItem extends StatelessWidget {
  const CustomOrderItem({
    super.key,
    required this.coffeeItem,
    required this.onIncrease,
    required this.onDecrease,
  });

  final CoffeeItem coffeeItem;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColorsDarkTheme.greyAppColor,
          AppColorsDarkTheme.darkBlueAppColor,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              coffeeItem.image,
              height: 120.h,
              width: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  coffeeItem.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 2),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColorsDarkTheme.darkBlueAppColor),
                      child: Center(
                        child: Text(
                          coffeeItem.selectedSize,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: '\$ ',
                          style: TextStyle(
                              color: AppColorsDarkTheme.brownAppColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20)),
                      TextSpan(
                          style: TextStyle(
                              color: AppColorsDarkTheme.whiteAppColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                          text: '${coffeeItem.sizes[coffeeItem.selectedSize]}')
                    ]))
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: onDecrease,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColorsDarkTheme.brownAppColor),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.remove,
                            ),
                          ),
                        )),
                    Container(
                      width: 60,
                      height: 35,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColorsDarkTheme.brownAppColor),
                          borderRadius: BorderRadius.circular(8),
                          color: AppColorsDarkTheme.darkBlueAppColor),
                      child: Center(
                        child: Text(
                          "${coffeeItem.quantityInCart}",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: onIncrease,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColorsDarkTheme.brownAppColor),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          // const SizedBox(width: 10),
        ],
      ),
    );
  }
}
