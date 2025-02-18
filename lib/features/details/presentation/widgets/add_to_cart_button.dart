import 'package:coffe_app/Admin/main_admin.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/data/models/coffe_item.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton(
      {super.key, required this.price, required this.coffeeItem});
  final String price;
  final CoffeeItem coffeeItem;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        width: 345,
        decoration: BoxDecoration(
          color: AppColorsDarkTheme.darkBlueAppColor,
          borderRadius: BorderRadius.circular(34),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                print(widget.coffeeItem.uniqueId);
                print(widget.coffeeItem.selectedSize);
                final isItemInCart = context
                    .read<UserDataCubit>()
                    .userCart
                    .any((item) => item.uniqueId == widget.coffeeItem.uniqueId);
                if (isItemInCart) {
                  showToastMsg('Item already in cart!');
                } else {
                  if (widget.coffeeItem.uniqueId.isEmpty) {
                    showToastMsg('Please select size');
                    return;
                  } else {
                    try {
                      setState(() {
                        pressed = true;
                      });
                      context
                          .read<UserDataCubit>()
                          .addToCart(widget.coffeeItem)
                          .then((_) {
                        setState(() {
                          pressed = false;
                        });
                        showToastMsg('Item added to cart successfully!');
                      });
                    } catch (e) {
                      setState(() {
                        pressed = false;
                      });
                      showToastMsg(e.toString());
                    }
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 3 / 4 - 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: pressed
                        ? AppColors.offWhiteAppColor
                        : AppColorsDarkTheme.brownAppColor),
                child: Center(
                  child: pressed
                      ? CustomLoadingProgress()
                      : Text(
                          'Add To Cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(
                      color: AppColorsDarkTheme.greyLighterAppColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                    text: '\$ ',
                    style: const TextStyle(
                        color: AppColors.brownAppColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                  ),
                  TextSpan(
                    text: widget.price,
                    style: const TextStyle(
                        color: AppColorsDarkTheme.whiteAppColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                  )
                ])),
              ],
            )
          ],
        ));
  }
}
