import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/widgets/custom_loading_progress.dart';
import '../widgets/empty_cart_screen.dart';
import '../widgets/not_empty_cart_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserDataCubit>().fetchUserCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.brownAppColor,
          foregroundColor: AppColors.offWhiteAppColor,
          centerTitle: true,
          title: Text(
            'Cart',
            style: TextStyle(
              fontFamily: 'Lato',
              color: AppColors.offWhiteAppColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: 1.5,
            ),
          )),
      backgroundColor: AppColors.offWhiteAppColor,
      body: BlocBuilder<UserDataCubit, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoading) {
            return const CustomLoadingProgress();
          }

          if (state is UserDataError) {
            return const Center(
              child: Text(
                'Failed to load user data',
                style: TextStyle(fontSize: 18, color: Colors.redAccent),
              ),
            );
          }

          if (state is UserDataSuccess) {
            final cartItems = state.userCart;
            if (cartItems.isEmpty) {
              return const EmptyCartScreen();
            }

            return NotEmptyCartScreen(
                discountPrice: totalPriceWithDiscount(cartItems),
                priceBeforeDiscount: totalPrice(cartItems),
                cartItems: cartItems);
          }
          return const EmptyCartScreen();
        },
      ),
    );
  }

  double totalPriceWithDiscount(List<CoffeeItem> items) {
    double sum = 0;
    for (var item in items) {
      sum += (item.sizes[item.selectedSize]! * item.quantityInCart);
    }

    if (sum > 20) {
      sum -= sum * (15 / 100);
    }
    return sum;
  }

  double totalPrice(List<CoffeeItem> items) {
    double sum = 0;
    for (var item in items) {
      sum += (item.sizes[item.selectedSize]! * item.quantityInCart);
    }

    return sum;
  }
}
