
import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../coffe_item.dart';
import 'hive_item.dart';


class MyHive {

  static late final Box<List<HiveItem>> hiveBox;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    // Register Adapters
    Hive.registerAdapter(HiveItemAdapter());
    Hive.registerAdapter(HiveIngredientAdapter());

    hiveBox = await Hive.openBox<List<HiveItem>>('hiveItemLists');
  }


// Saving the CoffeeItem to Hive
  static void saveSingleHiveItem(CoffeeItem coffeeItem,
      Box<List<HiveItem>> hiveBox) async {
    HiveItem item = convertToHiveItem(coffeeItem);

    // Retrieve the current list from Hive
    List<HiveItem> currentList = hiveBox.get(
        'hiveItemList', defaultValue: []) ?? [];

    // Add the new item to the list
    currentList.add(item);

    log("currentList length before saving: ${currentList.length}");

    // Save the updated list back to Hive
    await hiveBox.put('hiveItemList', currentList);
    log("Data saved to Hive");
  }

// Retrieving the list of CoffeeItem from Hive
  static List<CoffeeItem> getCoffeeItemList(Box<List<HiveItem>> hiveBox) {
    // Retrieve the list of HiveItem from the box
    List<HiveItem> hiveItemList = hiveBox.get(
        'hiveItemList', defaultValue: []) ?? [];

    log("hiveItemList length: ${hiveItemList.length}");

    if (hiveItemList.isEmpty) {
      log("No items in Hive");
    }

    // Convert the list of HiveItem to a list of CoffeeItem
    return convertToCoffeeItems(hiveItemList);
  }


  static HiveItem convertToHiveItem(CoffeeItem coffeeItem) {
    return HiveItem(
      id: coffeeItem.id,
      name: coffeeItem.name,
      description: coffeeItem.description,
      image: coffeeItem.image,
      category: coffeeItem.category,
      rate: coffeeItem.rate,
      ingredients: coffeeItem.ingredients
          .map((ingredient) =>
          HiveIngredient(
            name: ingredient.name,
            image: ingredient.image,
          ))
          .toList(),
      sizes: coffeeItem.sizes,
    );
  }

  static List<CoffeeItem> convertToCoffeeItems(List<HiveItem> hiveItems) {
    return hiveItems.map((hiveItem) {
      return CoffeeItem(
        id: hiveItem.id,
        name: hiveItem.name,
        description: hiveItem.description,
        image: hiveItem.image,
        category: hiveItem.category,
        rate: hiveItem.rate,
        ingredients: hiveItem.ingredients.map((hiveIngredient) {
          return Ingredient(
            name: hiveIngredient.name,
            image: hiveIngredient.image,
          );
        }).toList(),
        sizes: hiveItem.sizes,
      );
    }).toList();
  }

  static void deleteAllFavourites() async {
// Clear the box (removes all data)
    await hiveBox.clear();
  }

  deleteSpecificItem(String id) async {
// Retrieve the list of HiveItem
    List<HiveItem> hiveItemList = hiveBox.get(
        'hiveItemList', defaultValue: []) ?? [];

// Remove a specific item based on a condition
    hiveItemList.removeWhere((item) => item.id == id);

// Save the updated list back to Hive
    await hiveBox.put('hiveItemList', hiveItemList);
  }
}