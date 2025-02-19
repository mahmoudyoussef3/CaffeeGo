import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../../../User/features/Orders/Data/models/order_model.dart';

class GetAllOrders {
  Future<List<OrderModel>> getAllOrders() async {
    List<OrderModel> myOrders = [];
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .orderBy('order.orderStartDate', descending: false)
          .get();

      for (var document in querySnapshot.docs) {
        var data = document.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('order')) {
          myOrders.add(OrderModel.fromJson(data['order']));
        } else {
          if (kDebugMode) {
            print('Null or invalid data found for document: ${document.id}');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting documents: $e');
      }
    }
    if (kDebugMode) {
      print(myOrders[0].orderTotalPrice);
    }
    if (kDebugMode) {
      print(myOrders[0].stateOfTheOrder);
    }
    if (kDebugMode) {
      print(myOrders[0].myOrders[0].name);
    }
    if (kDebugMode) {
      print(myOrders[0].userDataClass.name ?? 'Not provided');
    }

    return myOrders;
  }

  Future changeTheStateOfTHeOrder(String orderState, String orderId) async {
    try {
      var orderRef = FirebaseFirestore.instance.collection('orders');
      var snapshot =
          await orderRef.where('order.orderId', isEqualTo: orderId).get();
      if (snapshot.docs.isNotEmpty) {
        var docRef = snapshot.docs.first.reference;
        await docRef.update({'order.stateOfTheOrder': orderState});

        if (kDebugMode) {
          print('Order state changed');
        }
      } else {
        if (kDebugMode) {
          print('Order not found');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> changeTheStateOfTHeOrderInUserCollection(
      String newState, String userId, String orderId) async {
    try {
      var userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      var userSnapShot = await userRef.get();
      if (!userSnapShot.exists) return;

      List<dynamic> orders = userSnapShot.data()?['orders'] ?? [];
      final orderIndex =
          orders.indexWhere((order) => order['orderId'] == orderId);
      if (orderIndex == -1) return;

      orders[orderIndex]['stateOfTheOrder'] = newState;

      await userRef.update({'orders': orders});

      if (kDebugMode) {
        print('Order state updated successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
