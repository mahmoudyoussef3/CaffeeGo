part of 'coffee_items_cubit.dart';

abstract class CoffeeItemsState {}

class CoffeeItemsInitial extends CoffeeItemsState {}

class CoffeeItemsLoading extends CoffeeItemsState {}

class CoffeeItemsSuccess extends CoffeeItemsState {
  final List items;
  CoffeeItemsSuccess(this.items);
}

class CoffeeItemsError extends CoffeeItemsState {
  final String errorMessage;
  CoffeeItemsError(this.errorMessage);
}
