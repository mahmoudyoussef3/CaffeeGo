import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../Orders/Data/models/order_model.dart';

class UserData {
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  late dynamic userData;
  Future<List<CoffeeItem>> getCart() async {
    List<CoffeeItem> myCart = [];
    DocumentSnapshot userSnapshot = await docRef.get();
    if (userSnapshot.exists) {
      userData = userSnapshot.data();
    } else {
      if (kDebugMode) {
        print('User document does not exist.');
      }
    }
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (documentSnapshot.exists) {
      List<dynamic>? cartData = documentSnapshot.get('cart') as List<dynamic>?;
      if (cartData != null) {
        myCart = cartData.map((item) => CoffeeItem.fromMap(item)).toList();
      } else {
        print('Cart is empty or does not exist.');
      }
    } else {
      print('User document does not exist.');
    }
    return myCart;
  }

  Future<void> updateCart(List<CoffeeItem> cart) async {
    final cartData = cart.map((item) => item.toMap()).toList();

    await docRef.update({'cart': cartData});
  }

  Future<void> updateQuantityNumber(
      String selectedSize, String coffeeId, int newQuantity) async {
    try {
      DocumentSnapshot documentSnapshot = await docRef.get();
      if (documentSnapshot.exists) {
        List<dynamic> cartData = documentSnapshot.get('cart');
        List<dynamic> updatedCart = cartData.map((item) {
          if (item['id'] == coffeeId && selectedSize == item['selectedSize']) {
            item['quantity'] = newQuantity;
          }
          return item;
        }).toList();

        await docRef.update({'cart': updatedCart});
        print('Quantity updated successfully.');
      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Error updating quantity: $e');
    }
  }

  Future<void> addOrderToAdminOrders(OrderModel order) async {
    try {
      var uuid = Uuid();
      String orderId = uuid.v4();
      await FirebaseFirestore.instance
          .collection('orders')
          .add({'order': order.toJson(), 'orderId': orderId});

      print('Added order to admin order done');
    } catch (e) {
      print('Error adding document: $e');
    }
  }
}
