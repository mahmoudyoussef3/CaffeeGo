import 'package:coffe_app/Admin/Features/Users/Data/data_source/get_all_users.dart';
import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';

import '../data_source/get_all_orders.dart';

class AllOrdersRepo {

  AllOrdersRepo();

  Future<List<OrderModel>> getOrders() async {
    return await GetAllOrders().getAllOrders();
  }
}
