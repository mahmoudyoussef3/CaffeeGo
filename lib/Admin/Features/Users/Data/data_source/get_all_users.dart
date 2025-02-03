import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/features/cart/Data/DataSource/user_data_firebase.dart';
import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetAllUsers {
  Future<List<UserDataClass>> getAllUsers() async {
    List<UserDataClass> myUsers = [];
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (var document in querySnapshot.docs) {
        myUsers.add(
            UserDataClass.fromJson(document.data() as Map<String, dynamic>));
      }
    } catch (e) {
      print(e.toString());
    }

    return myUsers;
  }
}
