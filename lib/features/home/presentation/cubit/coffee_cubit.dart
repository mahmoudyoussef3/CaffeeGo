import 'package:bloc/bloc.dart';
import 'package:coffe_app/features/home/data/repos/data_repo.dart';
import 'package:meta/meta.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit(this.dataRepo) : super(CoffeeInitial());
  DataRepo dataRepo;
  List coffeeCategories = [];
  List coffeeItems = [];

  void fetchCoffeeCategories() async {
    emit(CoffeeLoading());
    try {
      coffeeCategories = await dataRepo.getAllCoffees();
      emit(CoffeeSuccess(coffeeCategories));
    } on Exception catch (e) {
      emit(CoffeeError(e.toString()));
    }
  }

  void fetchCoffeeItems() async {
    emit(CoffeeItemsLoading());
    try {
      coffeeItems = await dataRepo.fetchCoffeeItems();
      emit(FetchCoffeeItemsSuccess(coffeeItems));
    } on Exception catch (e) {
      emit(CoffeeItemsError(e.toString()));
    }
  }
}
