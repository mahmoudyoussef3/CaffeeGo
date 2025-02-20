import 'package:coffe_app/User/features/Orders/presentation/widgets/empty_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/components/app_components.dart';
import '../cubits/order_cubit/orders_cubit.dart';
import '../widgets/orders_list_view.dart';

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
              return AppComponents.customLoadingProgress();
            }

            if (state is OrdersError) {
              return Center(
                child: Text('Error: ${state.errorMessage}',
                    style: const TextStyle(color: Colors.red)),
              );
            }

            if (state is OrdersLoaded) {
              if (state.orders.isEmpty) {
                return const EmptyOrderScreen();
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18),
                  child: Column(
                    children: [
                      const Text(
                        'Order History',
                        style: TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: AppColorsDarkTheme.whiteAppColor),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      OrdersListView(orders: state.orders)
                    ],
                  ),
                );
              }
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
