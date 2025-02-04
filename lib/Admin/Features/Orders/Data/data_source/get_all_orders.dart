import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/cart/Data/DataSource/user_data_firebase.dart';
import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetAllOrders {
  Future<List<OrderModel>> getAllOrders() async {
    List<OrderModel> myOrders = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('orders').get();

      for (var document in querySnapshot.docs) {
        var data = document.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('order')) {
          myOrders.add(OrderModel.fromJson(data['order']));
        } else {
          print('Null or invalid data found for document: ${document.id}');
        }
      }
    } catch (e) {
      print('Error getting documents: $e');
    }
    print(myOrders[0].orderTotalPrice);
    print(myOrders[0].stateOfTheOrder);
    print(myOrders[0].myOrders[0].name);
    print(myOrders[0].userDataClass.name ?? 'Not provided');

    return myOrders;
  }

  Future changeTheStateOfTHeOrder(String orderState, String orderId) async {
    try {
      var orderRef = FirebaseFirestore.instance.collection('orders');
      var snapshot = await orderRef.where('orderId', isEqualTo: orderId).get();
      if (snapshot.docs.isNotEmpty) {
        var docRef = snapshot.docs.first.reference;
        await docRef.update({'order.stateOfTheOrder': orderState});

        print('Order state changed');
      } else {
        print('Order not found');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
