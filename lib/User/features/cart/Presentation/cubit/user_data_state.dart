part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class UserDataLoading extends UserDataState {}

class UserDataSuccess extends UserDataState {
  final List<CoffeeItem> userCart;

  UserDataSuccess(this.userCart);
}

class UserDataError extends UserDataState {
  final String errorMessage;

  UserDataError(this.errorMessage);
}

class UserDataCartUpdated extends UserDataState {
  final List<CoffeeItem> userCart;

  UserDataCartUpdated(this.userCart);
}
