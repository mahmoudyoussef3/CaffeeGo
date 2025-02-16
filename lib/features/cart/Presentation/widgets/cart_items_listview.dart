import 'package:coffe_app/features/cart/Presentation/widgets/dismissed_coffee_cart_item.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../cubit/user_data_cubit.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Dismissible(
              key: Key(widget.cartItems[index].toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                await context
                    .read<UserDataCubit>()
                    .deleteCart(widget.cartItems[index]);
                if (mounted) {
                  context.read<UserDataCubit>().fetchUserCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Item removed successfully',
                        style: TextStyle(color: AppColors.brownAppColor),
                      ),
                      backgroundColor: AppColors.offWhiteAppColor,
                    ),
                  );
                }
              },
              background: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red,
                ),
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
