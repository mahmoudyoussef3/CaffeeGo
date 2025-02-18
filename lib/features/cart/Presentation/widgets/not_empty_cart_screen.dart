import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/cart/Presentation/widgets/payment_summary.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:coffe_app/features/home/presentation/cubit/UserData_cubit/user_data_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: AppColorsDarkTheme.greyAppColor),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/icons/drawer_icon.png'),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Cart',
                style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: AppColorsDarkTheme.whiteAppColor),
              ),
              Spacer(),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        CartItemsListview(cartItems: widget.cartItems),
        SizedBox(),
        Container(
          padding: EdgeInsets.all(16),
          child: TextField(
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            controller: notesController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColorsDarkTheme.darkBlueAppColor),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: AppColorsDarkTheme.greyAppColor,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColorsDarkTheme.darkBlueAppColor),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Add Your Notes',
              hintStyle: TextStyle(
                  color: AppColorsDarkTheme.greyLessDegreeAppColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColorsDarkTheme.darkBlueAppColor),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: Icon(
                Icons.note_alt_outlined,
                color: AppColorsDarkTheme.greyLessDegreeAppColor,
              ),
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
