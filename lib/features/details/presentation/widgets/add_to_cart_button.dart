import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        height: 60,
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
                context.read<UserDataCubit>().addToCart(coffeeItem).then(
                  (value) {
                    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
                              fontWeight: FontWeight.w500),
                        )));
                  },
                );
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
                const SizedBox(
                  height: 5,
                )
              ],
            )
          ],
        )

        // const Center(
        //   child: Row(
        //     children: [
        //       Text("Add To Cart",
        //           style: TextStyle(color: Colors.white, fontSize: 18)),
        //       Spacer(),
        //       Text(
        //         "|",
        //         style: TextStyle(color: Colors.white, fontSize: 16),
        //       ),
        //       Spacer(),
        //       Text(
        //         "12 \$",
        //         style: TextStyle(color: Colors.white, fontSize: 16),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
