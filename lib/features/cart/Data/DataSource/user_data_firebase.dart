import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  Future<List<CoffeeItem>> getCart() async {
    List<CoffeeItem> myCart = [];
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

  Future<void> addToCart(List<CoffeeItem> cart) async {
    final cartData = cart.map((item) => item.toMap()).toList();
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await docRef.update({'cart': cartData});
  }
}
