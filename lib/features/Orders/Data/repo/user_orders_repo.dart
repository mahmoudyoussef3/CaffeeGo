import 'package:coffe_app/features/Orders/Data/DataSource/user_orders_data_firebase.dart';
import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/cart/Data/DataSource/user_data_firebase.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';

class UserOrdersRepo {
  OrderDataFirebase orderData;

  UserOrdersRepo(this.orderData);

  Future<List<OrderModel>> fetchOrders() async {
    final List<OrderModel> orders = await orderData.getOrders();
    print('Orders :$orders');
    return orders;
  }

  Future<void> addToOrderList(List<OrderModel> myOrders) async {
    await orderData.updateOrder(myOrders);
  }
}
