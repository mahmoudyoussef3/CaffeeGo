import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'user_data_state.dart';

class UserDataClassCubit extends Cubit<UserDataClassState> {
  UserDataClassCubit() : super(UserDataInitial());
  UserDataClass? userDataClass;

  Future<UserDataClass?> getUsername() async {
    emit(UserDataClassLoading());
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        userDataClass = UserDataClass(
          uuid: data['uid'] ?? '',
          name: data['displayName'] ?? 'Unknown',
          phoneNumber: data['phoneNumber'] ?? '0',
          email: data['email'] ?? '',
        );

        emit(UserDataClassLoaded(userDataClass: userDataClass!));
      } else {
        print("User document does not exist.");
        emit(UserDataClassError(errorMessage: "User document does not exist."));
      }
    } catch (e) {
      print("Error fetching username: $e");
      emit(UserDataClassError(errorMessage: e.toString()));
    }
    return userDataClass;
  }
}
