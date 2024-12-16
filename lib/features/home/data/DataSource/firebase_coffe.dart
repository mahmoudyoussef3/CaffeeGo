import 'package:cloud_firestore/cloud_firestore.dart';

class CoffeeDataSource {
  Future<List> getCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    List categories = [];
    for (var doc in querySnapshot.docs) {
      categories.add(doc.data());
    }
    return categories;
  }
}
