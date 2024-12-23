import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/data_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.dataRepo) : super(CategoryInitial());
  DataRepo dataRepo;
  List coffeeCategories = [];

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
