import 'package:bloc/bloc.dart';
import 'package:coffe_app/Admin/Features/Items/Data/Repo/admin_items_repo.dart';
import 'package:meta/meta.dart';

import '../../../../../features/home/data/models/coffe_item.dart';

part 'admin_items_state.dart';

class AdminItemsCubit extends Cubit<AdminItemsState> {
  AdminItemsCubit(this.adminItemsRepo) : super(AdminItemsInitial());
  AdminItemsRepo adminItemsRepo;

  Future addCoffeeItem(CoffeeItem coffee) async {
    emit(AdminItemsLoading());
    try {
      await adminItemsRepo.addCoffeeRepo(coffee);
      emit(AdminItemsLoaded());
    } catch (e) {
      emit(AdminItemsError(errorMessage: e.toString()));
    }
  }

  Future deleteCoffeeItem(String coffeeName) async {
    emit(AdminItemsLoading());
    try {
      await adminItemsRepo.deleteCoffeeRepo(coffeeName);
      emit(AdminItemsLoaded());
    } catch (e) {
      emit(AdminItemsError(errorMessage: e.toString()));
    }
  }
}
