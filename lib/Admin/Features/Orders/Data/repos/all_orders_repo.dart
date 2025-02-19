

import '../../../../../User/features/Orders/Data/models/order_model.dart';
import '../data_source/get_all_orders.dart';

class AllOrdersRepo {

  AllOrdersRepo();

  Future<List<OrderModel>> getOrders() async {
    return await GetAllOrders().getAllOrders();
  }
}
