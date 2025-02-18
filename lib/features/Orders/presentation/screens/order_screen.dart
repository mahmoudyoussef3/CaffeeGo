import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:coffe_app/features/Orders/presentation/cubits/order_cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../Admin/Features/Orders/Presentation/widgets/order_card.dart';
import '../../../../core/utils/app_colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const CustomLoadingProgress();
            }

            if (state is OrdersError) {
              return Center(
                child: Text('Error: ${state.errorMessage}',
                    style: const TextStyle(color: Colors.red)),
              );
            }

            if (state is OrdersLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
                child: Column(
                  children: [
                    Row(
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
                              child:
                                  Image.asset('assets/icons/drawer_icon.png'),
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
                    SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          indent: 30,
                          endIndent: 30,
                          color: AppColors.brownAppColor,
                        ),
                        //  padding: const EdgeInsets.all(12),
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];
                          print(order.stateOfTheOrder);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: OrderCard(
                              admin: false,
                              userName: "${index + 1}",
                              totalPrice: order.orderTotalPrice,
                              items: order.myOrders
                                  .map((item) => {
                                        "name": item.name,
                                        "quantity": item.quantityInCart,
                                      })
                                  .toList(),
                              orderDate: order.orderStartDate,
                              orderStatus: order.stateOfTheOrder,
                              qrWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'QR Code',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.qr_code,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ],
                              ),
                              onScanQr: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          AppColorsDarkTheme.whiteAppColor,
                                      title: Text(
                                        'Scan QR Code',
                                        style: TextStyle(
                                            color: AppColorsDarkTheme
                                                .darkBlueAppColor),
                                      ),
                                      content: SizedBox(
                                        height: 300.h,
                                        width: 300.w,
                                        child: QrImageView(
                                            data:
                                                "${order.userDataClass.name ?? 'UnKnownUser'} \n${order.myOrders.map((item) => "${item.name} - ${item.quantityInCart} - ${item.selectedSize}").toString()} "),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color getColor() {
      switch (status) {
        case 'Pending':
          return AppColors.brownAppColor;
        case 'inProgress':
          return Colors.blue;
        case 'Cancelled':
          return Colors.red;
        case 'Completed':
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

    return Chip(
      label: Row(
        children: [
          Icon(
            Icons.lock_clock,
            color: AppColors.offWhiteAppColor,
            size: 16,
          ),
          SizedBox(width: 5),
          Text(
            status,
            style: const TextStyle(color: AppColors.offWhiteAppColor),
          ),
        ],
      ),
      backgroundColor: getColor(),
    );
  }
}

//     Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.white,
//         title: const Text('Your Orders'),
//         backgroundColor: AppColors.brownAppColor,
//       ),
//       body: BlocBuilder<OrdersCubit, OrdersState>(
//         builder: (context, state) {
//           if (state is OrdersLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (state is OrdersError) {
//             return Center(
//               child: Text('Error: ${state.errorMessage}',
//                   style: const TextStyle(color: Colors.red)),
//             );
//           }
//
//           if (state is OrdersLoaded) {
//             return ListView.separated(
//               itemBuilder: (context, index) => ListTile(
//                 leading: Text(state.orders[index].stateOfTheOrder),
//                 title: Text('Order ${index + 1}'),
//                 subtitle: Text(
//                   'Items: ${state.orders[index].myOrders.map((item) => item.name).join(", ")}',
//                 ),
//               ),
//               separatorBuilder: (context, index) => const Divider(),
//               itemCount: state.orders.length,
//             );
//           }
//
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [

//                 const SizedBox(height: 20),
//                 const Text(
//                   'Scan this QR Code to verify your payment.',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//
//     );
//   }
//
//   // showSuccessfulPayment(BuildContext context) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return AlertDialog(
//   //         title: const Text('Payment Successful!'),
//   //         content: const Text(
//   //           'Your payment has been processed successfully.',
//   //           textAlign: TextAlign.center,
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }
// }
