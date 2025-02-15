import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AdminCategoryDataSource {
  Future addCategory(String categoryName) async {
    try {
      await FirebaseFirestore.instance.collection('categories').doc().set({
        'id': '1',
        'name': categoryName,
        'image': 'https://example.com/image.jpg'
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateCategoryName(String oldName, String newName) async {
    try {
      var categoryRef = FirebaseFirestore.instance.collection('categories');
      var snapshot = await categoryRef.where('name', isEqualTo: oldName).get();
      var docRef = snapshot.docs.first.reference;

      await docRef.update({'name': newName});
      if (kDebugMode) {
        print('Category name updated successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update category name: $e');
      }
    }
  }

  Future<void> deleteCategory(String categoryName) async {
    try {
      var categoryRef = FirebaseFirestore.instance.collection('categories');
      var snapshot =
          await categoryRef.where('name', isEqualTo: categoryName).get();
      var docRef = snapshot.docs.first.reference;

      await docRef.delete();
      if (kDebugMode) {
        print('Category name updated successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update category name: $e');
      }
    }
  }
}
