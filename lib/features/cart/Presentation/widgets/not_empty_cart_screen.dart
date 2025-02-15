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

  String _selectedPaymentMethod = 'Cash';

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
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Select Payment Method",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              RadioListTile(
                title: Text("Pay with Card"),
                value: 'Online Card',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: Text("Pay with Barista (Cash)"),
                value: 'Cash',
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value.toString();
                  });
                },
              ),
            ],
          ),
        ),
        PaymentSummary(
            priceWithoutDiscount: widget.priceBeforeDiscount,
            priceWithDiscount: widget.discountPrice),
        const SizedBox(height: 20),
        BlocBuilder<UserDataClassCubit, UserDataClassState>(
          builder: (context, state) {
            if (state is UserDataClassLoading) {
              return CircularProgressIndicator();
            } else if (state is UserDataClassLoaded) {
              return InkWell(
                onTap: () {
                  if (_selectedPaymentMethod == 'Online Card') {
                    context.read<PaymentCubit>().payWithPayMob(
                        widget.discountPrice, context, widget.cartItems);
                  } else {
                    context
                        .read<OrdersCubit>()
                        .updateOrderList(
                          OrderModel(
                            userRequirements: 'No requirements',
                            paymentMethod: 'Cash',
                            paymentProcess: false,
                            userDataClass: context
                                .read<UserDataClassCubit>()
                                .userDataClass!,
                            orderStartDate: DateTime.now(),
                            myOrders: widget.cartItems,
                            stateOfTheOrder: 'Pending',
                            orderTotalPrice:
                                widget.discountPrice.toStringAsFixed(2),
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
                                userRequirements: 'No requirements',
                                paymentMethod: 'Cash',
                                paymentProcess: false,
                                userDataClass: context
                                    .read<UserDataClassCubit>()
                                    .userDataClass!,
                                orderStartDate: DateTime.now(),
                                myOrders: widget.cartItems,
                                stateOfTheOrder: 'Pending',
                                orderTotalPrice:
                                    widget.discountPrice.toStringAsFixed(2),
                              ),
                            );
                      },
                    );
                    setState(() {});
                  }
                },
                child: PaymentBottomSheet(),
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
//Todo This must send notification to admin that this user ordered a new order.
// showModalBottomSheet(
//   context: context,
//   shape: const RoundedRectangleBorder(
//     borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//   ),
//   backgroundColor: Colors.white,
//   builder: (sheetContext) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       height: 300,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             width: 40,
//             height: 4,
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),
//           Image.network(
//             'https://paymob.com//8080/uploads/paymob/logos/1604489841acceptLogo1.png',
//             height: 80,
//           ),
//           const SizedBox(height: 20),
//           const Text(
//             'Choose Payment Method',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               PayWithCard(sheetContext: context, amount: amount),
//               const PayWithWallet()
//             ],
//           ),
//         ],
//       ),
//     );
//   },
// );
