import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../Data/models/order_model.dart';
import '../../../Data/repo/user_orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.userOrdersRepo) : super(OrdersInitial());
  UserOrdersRepo userOrdersRepo;
  List<OrderModel> orderList = [];

  Future fetchOrders() async {
    emit(OrdersLoading());
    try {
      List<OrderModel> orders = await userOrdersRepo.fetchOrders();
      orderList = orders;

      emit(OrdersLoaded(orders: orders));
    } catch (e) {
      emit(OrdersError(errorMessage: e.toString()));
    }
  }

  Future<void> updateOrderList(OrderModel order) async {
    OrdersLoading();
    try {
      await fetchOrders();
      orderList.add(order);
      await userOrdersRepo.addToOrderList(orderList);
      if (kDebugMode) {
        print('Item added successfully');
      }
      emit(OrdersLoaded(orders: orderList));
    } catch (e) {
      if (kDebugMode) {
        print('Item failed');
      }
      if (kDebugMode) {
        print(e.toString());
      }
      emit(OrdersError(errorMessage: e.toString()));
    }
  }
}
