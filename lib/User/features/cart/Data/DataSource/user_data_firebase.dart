import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/Admin/Features/AdminNotification/data/admin_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../../../../config/notifications.dart/send_notification_srevice.dart';
import '../../../Orders/Data/models/order_model.dart';
import '../../../home/data/models/coffe_item.dart';
import '../../../notification/data/user_notifications.dart';

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
        if (kDebugMode) {
          print('Cart is empty or does not exist.');
        }
      }
    } else {
      if (kDebugMode) {
        print('User document does not exist.');
      }
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
        if (kDebugMode) {
          print('Quantity updated successfully.');
        }
      } else {
        if (kDebugMode) {
          print('User document does not exist.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating quantity: $e');
      }
    }
  }

  Future<void> addOrderToAdminOrders(
    OrderModel order,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .add({'order': order.toJson()});
      sendNotificationToAdmin(
          token:
              'f1WleBFlRpyjCRFWKO73gs:APA91bEfoefsrWJ2TLj0vorM_cv6C1xjvVRPx_Vk8676BN7xMGxOct0DLslCjyjmJwu2wZai5Bas_dBg0CAJzd89B599NagJcTEPTaN7kQkmLKul2M-DW-w',
          title: "New order",
          body: '${order.userDataClass.name!} has ordered drink',
          data: {});
      if (kDebugMode) {
        print('Added order to admin order done');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error adding document: $e');
      }
    }
  }
}
