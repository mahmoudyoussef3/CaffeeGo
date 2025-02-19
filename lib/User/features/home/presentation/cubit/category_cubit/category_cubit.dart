import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/use_case/items_use_case.dart';
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

      if (coffeeCategories.isEmpty) {
        throw Exception("No categories found.");
      }
      emit(CategorySuccess(coffeeCategories));
    } catch (e) {
      emit(CategoryError(errorMessage: e.toString()));
    }
  }
}
