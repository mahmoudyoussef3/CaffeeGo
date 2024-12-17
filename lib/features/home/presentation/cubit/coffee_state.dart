part of 'coffee_cubit.dart';

@immutable
abstract class CoffeeState {}

class CoffeeInitial extends CoffeeState {}

class CoffeeLoading extends CoffeeState {}
class CoffeeItemsLoading extends CoffeeState {}

class CoffeeError extends CoffeeState {
  CoffeeError(this.errorMessage);
  final String errorMessage;
}
class CoffeeItemsError extends CoffeeState {
  CoffeeItemsError(this.errorMessage);
  final String errorMessage;
}

class CoffeeSuccess extends CoffeeState {
  CoffeeSuccess(this.myCategories);
  final List myCategories;
}

class FetchCoffeeItemsSuccess extends CoffeeState {
  FetchCoffeeItemsSuccess(this.coffeeItems);
  final List coffeeItems;
}
