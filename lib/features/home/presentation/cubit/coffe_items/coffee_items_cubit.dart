import 'package:bloc/bloc.dart';
import 'package:coffe_app/features/home/Domain/use_case/items_use_case.dart';
import 'package:meta/meta.dart';

part 'coffee_items_state.dart';

class CoffeeItemsCubit extends Cubit<CoffeeItemsState> {
  CoffeeItemsCubit(this.itemsUseCse) : super(CoffeeItemsInitial());
  List coffeeItems = [];
  ItemsUseCse itemsUseCse;
  String category = 'Espresso';

  void fetchCoffeeItems() async {
    emit(CoffeeItemsLoading());
    try {
      coffeeItems = await itemsUseCse.getItems(category);
      emit(CoffeeItemsSuccess(coffeeItems));
    } on Exception catch (e) {
      emit(CoffeeItemsError(e.toString()));
    }
  }
}
