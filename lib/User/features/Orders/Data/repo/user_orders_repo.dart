

import 'package:flutter/foundation.dart';

import '../DataSource/user_orders_data_firebase.dart';
import '../models/order_model.dart';

class UserOrdersRepo {
  OrderDataFirebase orderData;

  UserOrdersRepo(this.orderData);

  Future<List<OrderModel>> fetchOrders() async {
    final List<OrderModel> orders = await orderData.getOrders();
    if (kDebugMode) {
      print('Orders :$orders');
    }
    return orders;
  }

  Future<void> addToOrderList(List<OrderModel> myOrders) async {
    await orderData.updateOrder(myOrders);
  }
}
