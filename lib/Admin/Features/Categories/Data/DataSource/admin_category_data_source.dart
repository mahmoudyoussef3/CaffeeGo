import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCategoryDataSource {
  Future addCategory(String categoryName) async {
    try {
      await FirebaseFirestore.instance.collection('categories').doc().set({
        'id': '1',
        'name': categoryName,
        'image': 'https://example.com/image.jpg'
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateCategoryName(String oldName,String newName) async {
    try {
      var categoryRef = FirebaseFirestore.instance.collection('categories');
      var snapshot =
          await categoryRef.where('name', isEqualTo: oldName).get();
      var docRef = snapshot.docs.first.reference;

      await docRef.update({'name': newName});
      print('Category name updated successfully!');
    } catch (e) {
      print('Failed to update category name: $e');
    }
  }

  Future<void> deleteCategory(String categoryName) async {
    try {
      var categoryRef = FirebaseFirestore.instance.collection('categories');
      var snapshot =
          await categoryRef.where('name', isEqualTo: categoryName).get();
      var docRef = snapshot.docs.first.reference;

      await docRef.delete();
      print('Category name updated successfully!');
    } catch (e) {
      print('Failed to update category name: $e');
    }
  }
}
