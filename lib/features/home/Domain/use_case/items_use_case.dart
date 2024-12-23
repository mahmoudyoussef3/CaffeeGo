import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:coffe_app/features/home/data/repos/data_repo.dart';
import '../../data/DataSource/firebase_coffe.dart';

class ItemsUseCse {
  DataRepo dataRepo = DataRepo(coffeeDataSource: CoffeeDataSource());

  Future<List<CoffeeItem>> getItems(String category) async {
    List<CoffeeItem> myItems = (await dataRepo.fetchCoffeeItems())
        .where(
          (element) => element.category == category,
        )
        .toList();
    print(myItems);
    return myItems;
  }
}
