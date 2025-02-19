import 'dart:io';

import 'package:coffe_app/Admin/Features/Items/Data/DataSource/admin_items_data_source.dart';

import '../../../../../User/features/home/data/models/coffe_item.dart';

class AdminItemsRepo {
  AdminItemsDataSource adminItemsDataSource;
  AdminItemsRepo(this.adminItemsDataSource);

  Future addCoffeeRepo(CoffeeItem coffee) async {
    return await adminItemsDataSource.addCoffee(coffee);
  }

  Future deleteCoffeeRepo(String coffeeName) async {
    return await adminItemsDataSource.deleteCoffeeItem(coffeeName);
  }

  Future<String?> uploadImg(File imgFile) async {
    return await adminItemsDataSource.uploadImageToImgur(imgFile);
  }
}
