import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/features/home/Domain/use_case/items_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../../data/repos/data_repo.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.dataRepo, this.itemsUseCse) : super(CategoryInitial());
  DataRepo dataRepo;
  ItemsUseCse itemsUseCse;
  List coffeeCategories = [];
  String userName = '';

  Future<String?> getUsername(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        userName = userDoc['displayName'];
        return userDoc['displayName']; // Replace with your field name
      } else {
        print("User not found!");
        return null;
      }
    } catch (e) {
      print("Error fetching username: $e");
      return null;
    }
  }

  void fetchCoffeeCategories() async {
    emit(CategoryLoading());
    try {
      coffeeCategories = await dataRepo.getAllCoffees();

      if (coffeeCategories.isEmpty) {
        throw Exception("No categories found.");
      }
      emit(CategorySuccess(coffeeCategories));
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }
}
