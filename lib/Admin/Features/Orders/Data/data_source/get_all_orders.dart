import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/cart/Data/DataSource/user_data_firebase.dart';
import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetAllOrders {
  Future<List<OrderModel>> getAllOrders() async {
    //todo it should be get data because it`s still get error

    List<OrderModel> myOrders = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('orders').get();

      for (var document in querySnapshot.docs) {
        var data =
            document.data() as Map<String, dynamic>?;
        if (data != null) {
          myOrders.add(OrderModel.fromJson(data));
        } else {
          print('Null data found for document: ${document.id}');
        }
      }
    } catch (e) {
      print('Error getting documents: $e');
    }

    return myOrders;
  }
}
