import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/cart/Presentation/widgets/payment_summary.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:coffe_app/features/home/presentation/cubit/UserData_cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/utils/app_colors.dart';
import 'Payment_bottom_sheet/payment_bottom_sheet.dart';
import 'cart_items_listview.dart';

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
        CartItemsListview(cartItems: widget.cartItems),
        PaymentSummary(
            priceWithoutDiscount: widget.priceBeforeDiscount,
            priceWithDiscount: widget.discountPrice),
        const SizedBox(height: 20),
        BlocBuilder<UserDataClassCubit, UserDataClassState>(
          builder: (context, state) {
            if (state is UserDataClassLoading) {
              return CircularProgressIndicator();
            } else if (state is UserDataClassLoaded) {
              var uuid = Uuid();
              String orderId = uuid.v4();
              return PaymentBottomSheet(
                amount: widget.discountPrice,
                myOrder: OrderModel(
                    userDataClass:
                        context.read<UserDataClassCubit>().userDataClass!,
                    orderStartDate: DateTime.now(),
                    myOrders: widget.cartItems,
                    stateOfTheOrder: 'Pending',
                    orderTotalPrice: widget.discountPrice.toStringAsFixed(2)),
              );
            }
            return SizedBox.shrink();
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
