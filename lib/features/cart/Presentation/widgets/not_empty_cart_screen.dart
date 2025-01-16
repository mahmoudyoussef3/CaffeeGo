import 'package:coffe_app/features/cart/Presentation/widgets/payment_summary.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'Payment_bottom_sheet/payment_bottom_sheet.dart';
import 'cart_items_listview.dart';

class NotEmptyCartScreen extends StatelessWidget {
  const NotEmptyCartScreen(
      {super.key,
      required this.discountPrice,
      required this.priceBeforeDiscount,
      required this.cartItems});
  final double discountPrice;
  final double priceBeforeDiscount;
  final List<CoffeeItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Text(
            'Cart',
            style: TextStyle(
              color: AppColors.brownAppColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: 1.5,
            ),
          ),
        ),
        CartItemsListview(cartItems: cartItems),
        PaymentSummary(
            priceWithoutDiscount: priceBeforeDiscount,
            priceWithDiscount: discountPrice),
        const SizedBox(height: 20),
        PaymentBottomSheet(amount: discountPrice),
        const SizedBox(height: 20),
      ],
    );
  }
}
