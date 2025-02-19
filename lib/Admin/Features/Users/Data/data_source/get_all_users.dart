import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../../User/features/home/data/models/UserData/user_data.dart';

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
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return myUsers;
  }
}
