import 'package:hive/hive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../home/data/models/coffe_item.dart';

class CoffeeHiveService {
  Future<void> addItem(CoffeeItem coffeeItem) async {
    var box = await Hive.openBox<CoffeeItem>(AppStrings.hiveBoxName);
    await box.put(coffeeItem.id, coffeeItem);
  }

  Future<void> deleteAllItems() async {
    var box = await Hive.openBox<CoffeeItem>(AppStrings.hiveBoxName);
    await box.clear();
  }

  Future<void> deleteItem(String uniqueId) async {
    var box = await Hive.openBox<CoffeeItem>(AppStrings.hiveBoxName);
    await box.delete(uniqueId);
  }

  Future<List<CoffeeItem>> getAllItems() async {
    var box = await Hive.openBox<CoffeeItem>(AppStrings.hiveBoxName);
    return box.values.toList();
  }

  Future<bool> isItemAdded(String uniqueId) async {
    var box = await Hive.openBox<CoffeeItem>(AppStrings.hiveBoxName);
    return box.containsKey(uniqueId);
  }
}
