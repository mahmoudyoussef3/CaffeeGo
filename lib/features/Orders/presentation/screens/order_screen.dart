import 'package:coffe_app/features/Orders/presentation/cubits/order_cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
    return Scaffold(
      backgroundColor: AppColors.offWhiteAppColor,
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text(
          'Your Orders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrdersError) {
            return Center(
              child: Text('Error: ${state.errorMessage}',
                  style: const TextStyle(color: Colors.red)),
            );
          }

          if (state is OrdersLoaded) {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                indent: 30,
                endIndent: 30,
                color: AppColors.brownAppColor,
              ),
              padding: const EdgeInsets.all(12),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                print(order.stateOfTheOrder);
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.coffee),
                            SizedBox(width: 8),
                            Text(
                              'Order #${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            _buildStatusChip(order.stateOfTheOrder),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text('Total Price: \$${order.orderTotalPrice}',
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 16)),
                        const SizedBox(height: 10),
                        Divider(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Items:\n ${"-${order.myOrders.map((item) => item.name).join("\n -")}"}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '\n${order.myOrders.map((item) => item.quantityInCart).join("\n")}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(),
                        const SizedBox(height: 10),
                        Text('Order Date: ${order.orderStartDate.toString()}',
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 16)),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    ContinuousRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.brownAppColor),
                                foregroundColor: WidgetStatePropertyAll(
                                    AppColors.offWhiteAppColor)),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.offWhiteAppColor,
                                    title: Text('Scan QR Code'),
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
                            label: Icon(
                              Icons.qr_code,
                              color: AppColors.offWhiteAppColor,
                            )),
                        // const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
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
          // QrImageView(
          //   data: widget.qrData,
          //   size: 250,
          //   backgroundColor: Colors.white,
          //   version: QrVersions.auto,
          // ),
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
