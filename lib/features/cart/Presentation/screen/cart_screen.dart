import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../order_screen/presentation/widgets/order_item.dart';
import '../../../order_screen/presentation/widgets/toggle_buttons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

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
    return Scaffold(body: BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        if (state is UserDataLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserDataError) {
          return const Center(child: Text('Failed to load user data'));
        }
        if (state is UserDataSuccess) {
          final cartItems = state.userCart;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    width: double.infinity,
                    // height: 700,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ToggleButtonsWidget(),
                        SizedBox(
                          height: 24,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColors.offWhiteAppColor,
                          endIndent: 30,
                          indent: 30,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        CustomOrderItme(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final coffeeItem = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  coffeeItem.image,
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image,
                                          color: Colors.grey),
                                ),
                              ),
                              title: Text(
                                coffeeItem.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(coffeeItem.description,
                                      maxLines: 2, overflow: TextOverflow.ellipsis),
                                  Text('Price: ${coffeeItem.sizes.entries.first.value}',
                                      style: TextStyle(color: Colors.green[700])),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Remove item from cart logic
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        }
        ;

        return const SizedBox.shrink();
      },
    ));
  }
}
