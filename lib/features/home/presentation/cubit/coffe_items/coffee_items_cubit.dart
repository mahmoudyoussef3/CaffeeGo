import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:coffe_app/features/home/Domain/use_case/items_use_case.dart';
import 'package:meta/meta.dart';
part 'coffee_items_state.dart';

class CoffeeItemsCubit extends Cubit<CoffeeItemsState> {
  CoffeeItemsCubit(this.itemsUseCse) : super(CoffeeItemsInitial());
  List coffeeItems = [];
  ItemsUseCse itemsUseCse;
  String category = 'ALL';

  void fetchCoffeeItems() async {
    emit(CoffeeItemsLoading());
    try {
      coffeeItems = await itemsUseCse.getItems(category);
      emit(CoffeeItemsSuccess(coffeeItems));
      log('fetchCoffeeItems success:================================ ${coffeeItems}');
    } on Exception catch (e) {
      emit(CoffeeItemsError(e.toString()));
    }
  }

  void fetchCoffeeItemsBySearch(String searchText) async {
    log('fetchCoffeeItemsBySearch loading: $searchText');
    emit(CoffeeItemsLoading());
    try {
      coffeeItems = await itemsUseCse.getItemsBySearch(searchText);
      log('fetchCoffeeItemsBySearch success: $searchText');

      emit(CoffeeItemsSuccess(coffeeItems));
      log('fetchCoffeeItemsBySearch success: ${coffeeItems.length}');
    } on Exception catch (e) {
      log('fetchCoffeeItemsBySearch error: $searchText');

      emit(CoffeeItemsError(e.toString()));
    }
  }
}
