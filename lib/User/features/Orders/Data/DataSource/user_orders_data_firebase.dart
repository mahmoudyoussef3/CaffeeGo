import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/order_model.dart';

class OrderDataFirebase {
  DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  Future<List<OrderModel>> getOrders() async {
    List<OrderModel>? myOrders = [];

    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (documentSnapshot.exists) {
        List<dynamic>? orders =
            documentSnapshot.get('orders') as List<dynamic>?;
        myOrders = orders?.map((item) => OrderModel.fromJson(item)).toList();
      } else {
        if (kDebugMode) {
          print('User document does not exist.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting documents: $e');
      }
    }

    return myOrders!;
  }

  Future<void> updateOrder(List<OrderModel> order) async {
    final orders = order.map((item) => item.toJson()).toList();

    await docRef.update({'orders': orders});
  }


}
