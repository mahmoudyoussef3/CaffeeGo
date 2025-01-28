import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/data/models/coffe_item.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton(
      {super.key, required this.price, required this.coffeeItem});
  final String price;
  final CoffeeItem coffeeItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        width: 345,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(34),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                print(coffeeItem.uniqueId);
                print(coffeeItem.selectedSize);
                final isItemInCart = context
                    .read<UserDataCubit>()
                    .userCart
                    .any((item) => item.uniqueId == coffeeItem.uniqueId);
                if (isItemInCart) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.white,
                      content: Text(
                        'Item already in cart.',
                        style: TextStyle(
                            color: AppColors.secondaryBrownAppColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                } else {
                  if (coffeeItem.uniqueId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.white,
                        content: Text(
                          'Please select a size.',
                          style: TextStyle(
                            color: AppColors.secondaryBrownAppColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                    return;
                  } else {
                    context
                        .read<UserDataCubit>()
                        .addToCart(coffeeItem)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: "Cart",
                            textColor: AppColors.secondaryBrownAppColor,
                            onPressed: () =>
                                Navigator.pushNamed(context, AppStrings.cart),
                          ),
                          backgroundColor: Colors.white,
                          content: const Text(
                            'Item added to Cart',
                            style: TextStyle(
                              color: AppColors.secondaryBrownAppColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    });
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 3 / 4 - 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.brownAppColor),
                child: const Center(
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              indent: 5,
              width: 2,
              thickness: 2,
              color: AppColors.brownAppColor,
              endIndent: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "$price \$",
                  style: const TextStyle(
                      color: AppColors.brownAppColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
              ],
            )
          ],
        ));
  }
}
