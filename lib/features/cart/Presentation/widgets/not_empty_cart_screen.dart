import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/cart/Presentation/widgets/payment_summary.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:coffe_app/features/home/presentation/cubit/UserData_cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../Orders/presentation/cubits/order_cubit/orders_cubit.dart';
import '../../../payment/cubit/payment_cubit.dart';
import 'Payment_bottom_sheet/pay_with_card.dart';
import 'Payment_bottom_sheet/pay_with_wallet.dart';
import 'Payment_bottom_sheet/payment_bottom_sheet.dart';
import 'cart_items_listview.dart';

TextEditingController notesController = TextEditingController();

class NotEmptyCartScreen extends StatefulWidget {
  const NotEmptyCartScreen(
      {super.key,
      required this.discountPrice,
      required this.priceBeforeDiscount,
      required this.cartItems});

  final double discountPrice;
  final double priceBeforeDiscount;
  final List<CoffeeItem> cartItems;

  @override
  State<NotEmptyCartScreen> createState() => _NotEmptyCartScreenState();
}

class _NotEmptyCartScreenState extends State<NotEmptyCartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserDataClassCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        CartItemsListview(cartItems: widget.cartItems),
        SizedBox(),
        Container(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: notesController,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              labelText: 'Add Your Notes',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: Icon(Icons.note_alt_outlined),
            ),
          ),
        ),
        PaymentSummary(
            priceWithoutDiscount: widget.priceBeforeDiscount,
            priceWithDiscount: widget.discountPrice),
        const SizedBox(height: 16),
        PaymentBottomSheet(
          finalPrice: widget.discountPrice,
          cartItems: widget.cartItems,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
