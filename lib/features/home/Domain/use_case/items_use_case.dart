import 'dart:developer';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:coffe_app/features/home/data/repos/data_repo.dart';
import '../../data/DataSource/firebase_coffe.dart';

class ItemsUseCse {
  DataRepo dataRepo = DataRepo(coffeeDataSource: CoffeeDataSource());

  Future<List<CoffeeItem>> getItems(String category) async {
    if (category == 'ALL') {
      List<CoffeeItem> myItems = (await dataRepo.fetchCoffeeItems());
      return myItems;
    } else {
      List<CoffeeItem> myItems = (await dataRepo.fetchCoffeeItems())
          .where(
            (element) => element.category == category,
          )
          .toList();
      return myItems;
    }
  }
  Future<List<CoffeeItem>> getItemsBySearch(String searchText) async {

      List<CoffeeItem> itemsBySearch = (await dataRepo.fetchCoffeeItems())
          .where(
            (element) => element.name.toLowerCase().contains(searchText.toLowerCase()),
          )
          .toList();
      return itemsBySearch;
    }
}
