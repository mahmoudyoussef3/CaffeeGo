// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coffe_app/features/home/data/models/coffe_item.dart';
//
// class AdminCategoryDataSource {
//   Future addItem(CoffeeItem coffeeItem) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('coffee_items')
//           .doc()
//           .set(coffeeItem.toMap());
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> updateCoffeeItem(
//       CoffeeItem oldCoffeeItem, CoffeeItem newOldCoffeeItem) async {
//     try {
//       var categoryRef = FirebaseFirestore.instance.collection('categories');
//       var snapshot = await categoryRef.where('name', isEqualTo: oldName).get();
//       var docRef = snapshot.docs.first.reference;
//
//       await docRef.update({'name': newName});
//       print('Category name updated successfully!');
//     } catch (e) {
//       print('Failed to update category name: $e');
//     }
//   }
//
//   Future<void> deleteCoffeeItem(String itemName) async {
//     try {
//       var categoryRef = FirebaseFirestore.instance.collection('coffee_items');
//       var snapshot = await categoryRef.where('name', isEqualTo: itemName).get();
//       var docRef = snapshot.docs.first.reference;
//
//       await docRef.delete();
//       print('Item deleted successfully!');
//     } catch (e) {
//       print('Failed to delete item : $e');
//     }
//   }
// }
