import 'package:bloc/bloc.dart';
import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/Orders/Data/repo/user_orders_repo.dart';
import 'package:meta/meta.dart';

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
      print('Item added successfully');
      emit(OrdersLoaded(orders: orderList));
    } catch (e) {
      print('Item failed');
      print(e.toString());
      emit(OrdersError(errorMessage: e.toString()));
    }
  }
}
