import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../../User/features/home/data/models/coffe_item.dart';

class AdminItemsDataSource {
  Future addCoffee(CoffeeItem coffeeItem) async {
    try {
      await FirebaseFirestore.instance
          .collection('coffee_items')
          .doc()
          .set(coffeeItem.toMap());
      if (kDebugMode) {
        print('Coffee item added successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print('Failed to add coffee item: $e');
      }
    }
  }

  Future<String?> uploadImageToImgur(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.imgur.com/3/image'),
    );
    request.headers['Authorization'] = 'feb2c06bb1eb337';
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonData = jsonDecode(responseData);

    if (response.statusCode == 200) {
      return jsonData['data']['link'];
    } else {
      if (kDebugMode) {
        print('Failed to upload: ${jsonData['data']['error']}');
      }
      return null;
    }
  }

  Future<void> deleteCoffeeItem(String itemName) async {
    try {
      var categoryRef = FirebaseFirestore.instance.collection('coffee_items');
      var snapshot = await categoryRef.where('name', isEqualTo: itemName).get();
      var docRef = snapshot.docs.first.reference;

      await docRef.delete();
      if (kDebugMode) {
        print('Item deleted successfully!');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to delete item : $e');
      }
    }
  }
}
