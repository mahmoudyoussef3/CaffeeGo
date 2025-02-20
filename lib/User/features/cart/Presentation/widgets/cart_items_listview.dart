import 'package:coffe_app/Admin/main_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/components/app_components.dart';
import '../../../home/data/models/coffe_item.dart';
import '../cubit/user_data_cubit.dart';
import 'dismissed_coffee_cart_item.dart';

class CartItemsListview extends StatefulWidget {
  const CartItemsListview({super.key, required this.cartItems});
  final List<CoffeeItem> cartItems;

  @override
  State<CartItemsListview> createState() => _CartItemsListviewState();
}

class _CartItemsListviewState extends State<CartItemsListview> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: widget.cartItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Dismissible(
              key: Key(widget.cartItems[index].toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                await context
                    .read<UserDataCubit>()
                    .deleteCart(widget.cartItems[index]);
                if (mounted) {
                  context.read<UserDataCubit>().fetchUserCart();
                  AppComponents.showToastMsg('Item removed successfully');
                }
              },
              background: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColorsDarkTheme.redAppColor),
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              child: DismissedCoffeeCartItem(
                  cartItems: widget.cartItems, index: index)),
        );
      },
    ));
  }
}
