import '../DataSource/firebase_coffe.dart';
import '../models/coffe_item.dart';

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
