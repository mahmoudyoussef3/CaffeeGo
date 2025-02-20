import 'package:coffe_app/User/features/cart/Presentation/widgets/Payment_bottom_sheet/pay_with_card.dart';
import 'package:coffe_app/User/features/cart/Presentation/widgets/Payment_bottom_sheet/pay_with_wallet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../Admin/main_admin.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/components/app_components.dart';
import '../../../../Orders/Data/models/order_model.dart';
import '../../../../Orders/presentation/cubits/order_cubit/orders_cubit.dart';
import '../../../../home/data/models/coffe_item.dart';
import '../../../../home/presentation/cubit/UserData_cubit/user_data_cubit.dart';
import '../../cubit/user_data_cubit.dart';
import '../not_empty_cart_screen.dart';

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({
    super.key,
    required this.finalPrice,
    required this.cartItems,
  });
  final double finalPrice;
  final List<CoffeeItem> cartItems;

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataClassCubit, UserDataClassState>(
      builder: (context, state) {
        if (state is UserDataClassLoading) {
          return  AppComponents.customLoadingProgress();
        } else if (state is UserDataClassLoaded) {
          return Row(children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: pressed
                      ? AppColors.offWhiteAppColor
                      : AppColors.brownAppColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 4,
                ),
                onPressed: () {
                  setState(() {
                    pressed = true;
                  });
                  try {
                    context
                        .read<OrdersCubit>()
                        .updateOrderList(
                          OrderModel(
                            userRequirements: notesController.text,
                            paymentMethod: 'Cash',
                            paymentProcess: false,
                            userDataClass: context
                                .read<UserDataClassCubit>()
                                .userDataClass!,
                            orderStartDate: DateTime.now(),
                            myOrders: widget.cartItems,
                            stateOfTheOrder: 'Pending',
                            orderTotalPrice:
                                widget.finalPrice.toStringAsFixed(2),
                          ),
                        )
                        .then(
                      (value) {
                        context.read<UserDataCubit>().clearCart();
                      },
                    ).then(
                      (value) {
                        context.read<UserDataCubit>().addOrderToOrdersAdmin(
                              OrderModel(
                                userRequirements: notesController.text,
                                paymentMethod: 'Cash',
                                paymentProcess: false,
                                userDataClass: context
                                    .read<UserDataClassCubit>()
                                    .userDataClass!,
                                orderStartDate: DateTime.now(),
                                myOrders: widget.cartItems,
                                stateOfTheOrder: 'Pending',
                                orderTotalPrice:
                                    widget.finalPrice.toStringAsFixed(2),
                              ),
                            );
                        setState(() {
                          pressed = false;
                        });
                        AppComponents.showToastMsg('Order Sent Successfully!');
                        if (kDebugMode) {
                          print("is my userReq ${notesController.text}");
                        }
                      },
                    );
                  } catch (e) {
                    setState(() {
                      pressed = false;
                    });
                  }
                },
                child: pressed
                    ?  Center(
                        child: AppComponents.customLoadingProgress()
                      )
                    : const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Submit Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '(Pay Cash)',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColorsDarkTheme.greyAppColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 4,
                ),
                onPressed: () => showBottomSheet(context, widget.finalPrice),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    color: AppColorsDarkTheme.greyLighterAppColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            )
          ]);
        }
        return const SizedBox.shrink();
      },
    );
  }

  void showBottomSheet(BuildContext context, double amount) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: AppColorsDarkTheme.darkBlueAppColor,
      builder: (sheetContext) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 250,
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Image.network(
                'https://paymob.com//8080/uploads/paymob/logos/1604489841acceptLogo1.png',
                height: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Payment Method',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PayWithCard(
                    sheetContext: context,
                    amount: amount,
                    cartItems: widget.cartItems,
                    orderModel: OrderModel(
                      userRequirements: notesController.text,
                      paymentMethod: 'Online Card',
                      paymentProcess: true,
                      userDataClass:
                          context.read<UserDataClassCubit>().userDataClass!,
                      orderStartDate: DateTime.now(),
                      myOrders: widget.cartItems,
                      stateOfTheOrder: 'Pending',
                      orderTotalPrice: widget.finalPrice.toStringAsFixed(2),
                    ),
                  ),
                  const PayWithWallet()
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
