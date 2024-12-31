import 'package:bloc/bloc.dart';
import 'package:coffe_app/features/home/Domain/use_case/items_use_case.dart';
import 'package:meta/meta.dart';
import '../../../data/repos/data_repo.dart';
part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.dataRepo, this.itemsUseCse) : super(CategoryInitial());
  DataRepo dataRepo;
  ItemsUseCse itemsUseCse;
  List coffeeCategories = [];

  void fetchCoffeeCategories() async {
    emit(CategoryLoading());
    try {
       coffeeCategories = await dataRepo.getAllCoffees();
    //  coffeeCategories = await itemsUseCse.getItems();

      if (coffeeCategories.isEmpty) {
        throw Exception("No categories found.");
      }
      emit(CategorySuccess(coffeeCategories));
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }
}
