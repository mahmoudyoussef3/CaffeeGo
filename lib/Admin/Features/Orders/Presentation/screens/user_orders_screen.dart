import 'package:coffe_app/Admin/Features/Orders/Presentation/cubits/get_all_users_cubit/get_all_orders_cubit.dart';
import 'package:coffe_app/Admin/Features/Orders/Presentation/screens/scanner.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../widgets/order_card.dart';
import 'order-details.dart';

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
      body: StreamBuilder<GetAllOrdersState>(
          stream: context.read<GetAllOrdersCubit>().stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CustomLoadingProgress());
            }
            if (snapshot.hasData) {
              final state = snapshot.data;
              if (state is GetAllOrdersSuccess) {
                return ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    var order = state.orders[index];
                    return InkWell(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderDetailsScreen(
                                    order: order,
                                  ))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 16),
                        child: OrderCard(
                          userName: order.userDataClass.name!,
                          totalPrice: order.orderTotalPrice,
                          items: order.myOrders
                              .map((item) => {
                                    "name": item.name,
                                    "quantity": item.quantityInCart,
                                  })
                              .toList(),
                          orderDate: order.orderStartDate,
                          orderStatus: order.stateOfTheOrder,
                          onScanQr: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QRScannerScreen(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            }
            return Center(child: Text("No orders available"));
          }),
    );
  }
}
