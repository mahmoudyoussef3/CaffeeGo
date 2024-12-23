import 'package:coffe_app/features/home/data/models/coffe_item.dart';

import '../DataSource/firebase_coffe.dart';

class DataRepo {
  DataRepo({required this.coffeeDataSource});
  CoffeeDataSource coffeeDataSource;

  Future<List<dynamic>> getAllCoffees() async {
    return coffeeDataSource.getCategories();
  }

  Future<List<CoffeeItem>> fetchCoffeeItems() async {
    return coffeeDataSource.fetchCoffeeItems();
  }
}
