import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Orders/Data/models/order_model.dart';
import '../../../home/data/models/coffe_item.dart';
import '../../Data/repo/user_data_repo.dart';

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
      if (kDebugMode) {
        print(userCart.length);
      }

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
      if (kDebugMode) {
        print('Item added successfully');
      }
      emit(UserDataCartUpdated(userCart));
    } catch (e) {
      if (kDebugMode) {
        print('Item failed');
      }
      if (kDebugMode) {
        print(e.toString());
      }
      emit(UserDataError(e.toString()));
    }
  }

  Future updateQuantity(String selectedSize, String id, int number) async {
    UserDataLoading();
    try {
      await dataRepo.updateQuantity(selectedSize, id, number);
      if (kDebugMode) {
        print('Item quantity updated successfully');
      }
      emit(UserDataSuccess(userCart));
    } catch (e) {
      if (kDebugMode) {
        print('Item updated failed');
      }
      if (kDebugMode) {
        print(e.toString());
      }
      emit(UserDataError(e.toString()));
    }
  }

  Future clearCart() async {
    UserDataLoading();
    try {
      await fetchUserCart();
      userCart.clear();
      await dataRepo.addToCart(userCart);
      if (kDebugMode) {
        print('Cart Deleted successfully');
      }
      emit(UserDataCartUpdated(userCart));
    } catch (e) {
      if (kDebugMode) {
        print('Item failed');
      }
      if (kDebugMode) {
        print(e.toString());
      }
      emit(UserDataError(e.toString()));
    }
  }

  Future<void> deleteCart(CoffeeItem item) async {
    try {
      final currentState = state;
      if (currentState is UserDataSuccess) {
        userCart.remove(item);
        await dataRepo.addToCart(userCart);
        if (kDebugMode) {
          print('Item deleted successfully');
        }
        final List<CoffeeItem> updatedCart = List.from(currentState.userCart)
          ..remove(item);
        emit(UserDataSuccess(updatedCart));
      }
    } catch (e) {
      emit(UserDataError(e.toString()));
    }
  }

  Future addOrderToOrdersAdmin(OrderModel order) async {
    UserDataLoading();
    try {
      await dataRepo.addOrderToAdminOrders(order);
      if (kDebugMode) {
        print('Order sent to admin successfully');
      }
      emit(UserDataSuccess(userCart));
    } catch (e) {
      if (kDebugMode) {
        print('Order failed to send');
      }
      if (kDebugMode) {
        print(e.toString());
      }
      emit(UserDataError(e.toString()));
    }
  }
}
