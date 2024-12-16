import '../DataSource/firebase_coffe.dart';

class DataRepo {
  DataRepo({required this.coffeeDataSource});
  CoffeeDataSource coffeeDataSource;

  Future<List<dynamic>> getAllCoffees() async {
    return coffeeDataSource.getCategories();
  }
}
