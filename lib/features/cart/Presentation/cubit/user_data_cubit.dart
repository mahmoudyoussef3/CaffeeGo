import 'package:coffe_app/features/cart/Data/repo/user_data_repo.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this.dataRepo) : super(UserDataInitial());
  UserDataRepo dataRepo;
  List<CoffeeItem> userCart = [];

  Future fetchUserCart() async {
    emit(UserDataLoading());
    try {
      final List<CoffeeItem> userCartFirebase = await dataRepo.fetchCart();
      userCart = userCartFirebase;
      print(userCart.length);

      emit(UserDataSuccess(userCart));
    } on Exception catch (e) {
      emit(UserDataError(e.toString()));
    }
  }

  Future addToCart(CoffeeItem item) async {
    UserDataLoading();
    try {
      await fetchUserCart();
      userCart.add(item);
      await dataRepo.addToCart(userCart);
      print('Item added successfully');
      emit(UserDataCartUpdated(userCart));
    } catch (e) {
      print('Item failed');
      print(e.toString());
      emit(UserDataError(e.toString()));
    }
  }

  Future updateQuantity(String selectedSize, String id, int number) async {
    UserDataLoading();
    try {
      await dataRepo.updateQuantity(selectedSize, id, number);
      print('Item quantity updated successfully');
      emit(UserDataSuccess(userCart));
    } catch (e) {
      print('Item updated failed');
      print(e.toString());
      emit(UserDataError(e.toString()));
    }
  }

  // Future updateSelectedSize(String id, String selectedSize) async {
  //   UserDataLoading();
  //   try {
  //     await dataRepo.updateSelectedSize(id, selectedSize);
  //     print('Item selectedSize updated successfully');
  //     emit(UserDataSuccess(userCart));
  //   } catch (e) {
  //     print('Item updated failed');
  //     print(e.toString());
  //     emit(UserDataError(e.toString()));
  //   }
  // }

  Future<void> deleteCart(CoffeeItem item) async {
    try {
      final currentState = state;
      if (currentState is UserDataSuccess) {
        userCart.remove(item);
        await dataRepo.addToCart(userCart);
        print('Item deleted successfully');
        final List<CoffeeItem> updatedCart = List.from(currentState.userCart)
          ..remove(item);
        emit(UserDataSuccess(updatedCart));
      }
    } catch (e) {
      emit(UserDataError(e.toString()));
    }
  }
}
