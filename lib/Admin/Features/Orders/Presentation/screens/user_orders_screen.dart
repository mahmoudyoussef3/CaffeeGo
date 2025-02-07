import 'package:coffe_app/Admin/Features/Orders/Presentation/cubits/get_all_users_cubit/get_all_orders_cubit.dart';
import 'package:coffe_app/Admin/Features/Orders/Presentation/screens/order-details.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';

class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  State<ManageOrdersScreen> createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllOrdersCubit>().getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          foregroundColor: AppColors.offWhiteAppColor,
          title: const Text('Manage Orders'),
          backgroundColor: AppColors.brownAppColor),
      body: BlocBuilder<GetAllOrdersCubit, GetAllOrdersState>(
        builder: (context, state) {
          if (state is GetAllOrdersLoading) {
            return Center(child: CustomLoadingProgress());
          } else if (state is GetAllOrdersFailure) {
            return Text('Failed to fetch orders');
          } else if (state is GetAllOrdersSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetailsScreen(order: state.orders[index]),
                      )),
                  child: _buildOrderCard(
                      context,
                      state.orders[index].orderStartDate.toString(),
                      state.orders[index]),
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOrderCard(
      BuildContext context, String orderId, OrderModel order) {
    Color getColor() {
      switch (order.stateOfTheOrder) {
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
                Icon(Icons.person),
                SizedBox(width: 8),
                Text(
                  '${order.userDataClass.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: getColor(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 40,
                  width: 100,
                  child: Center(
                    child: Text(
                      order.stateOfTheOrder,
                      style: TextStyle(color: AppColors.offWhiteAppColor),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text('Total Price: \$${order.orderTotalPrice}',
                style: const TextStyle(color: Colors.black87, fontSize: 16)),
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
                style: const TextStyle(color: Colors.black87, fontSize: 16)),

            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
