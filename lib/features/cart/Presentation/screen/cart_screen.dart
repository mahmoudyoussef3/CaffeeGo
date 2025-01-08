import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../order_screen/presentation/widgets/order_item.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F5F2),
        body: BlocBuilder<UserDataCubit, UserDataState>(
          builder: (context, state) {
            if (state is UserDataLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.brownAppColor,
              ));
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
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.coffee,
                        size: 100,
                        color: AppColors.brownAppColor,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Your cart is empty!',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.brownAppColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Start adding items to your cart.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
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
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(
                        color: AppColors.brownAppColor,
                        indent: 50,
                        endIndent: 50,
                      ),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Dismissible(
                            key: Key(cartItems[index].toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              await context
                                  .read<UserDataCubit>()
                                  .deleteCart(cartItems[index]);
                              if (mounted) {
                                context.read<UserDataCubit>().fetchUserCart();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Item removed successfully',
                                      style: TextStyle(
                                          color: AppColors.brownAppColor),
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
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () =>
                                    print(cartItems[index].selectedSize),
                                child: CustomOrderItem(
                                  coffeeItem: cartItems[index],
                                  onDecrease: () async {
                                    setState(() {
                                      cartItems[index].quantityInCart > 1
                                          ? cartItems[index].quantityInCart--
                                          : null;
                                    });
                                    await context
                                        .read<UserDataCubit>()
                                        .updateQuantity(
                                            cartItems[index].selectedSize,
                                            cartItems[index].id,
                                            cartItems[index].quantityInCart);
                                  },
                                  onIncrease: () async {
                                    setState(() {
                                      cartItems[index].quantityInCart++;
                                    });
                                    await context
                                        .read<UserDataCubit>()
                                        .updateQuantity(
                                            cartItems[index].selectedSize,
                                            cartItems[index].id,
                                            cartItems[index].quantityInCart);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 70,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 150,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          height: 120,
                                          width: 150,
                                          fit: BoxFit.cover,
                                          'assets/images/card.svg'),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Image.asset(
                                          height: 120,
                                          width: 150,
                                          fit: BoxFit.cover,
                                          'assets/images/3a0870c1369eb2bc105bd4838665defa.png')
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.60,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.brownAppColor,
                            ),
                            child: const Text(
                              'Order Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  color: AppColors.brownAppColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${totalPrice(
                                  cartItems,
                                )} \$',
                                style: const TextStyle(
                                  color: AppColors.brownAppColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }

            return const Center(
              child: Text(
                'Unknown state!',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            );
          },
        ),
      ),
    );
  }

  String totalPrice(List<CoffeeItem> items) {
    double sum = 0;
    for (var item in items) {
      sum += (item.sizes[item.selectedSize]! * item.quantityInCart);
    }
    return sum.toStringAsFixed(2);
  }
}
