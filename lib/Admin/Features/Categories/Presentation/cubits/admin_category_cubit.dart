import 'package:coffe_app/Admin/Features/Categories/Data/DataSource/admin_category_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_category_state.dart';

class AdminCategoryCubit extends Cubit<AdminCategoryState> {
  AdminCategoryCubit(this.adminCategoryDataSource)
      : super(AdminCategoryInitial());
  AdminCategoryDataSource adminCategoryDataSource;

  Future addCategory(String category) async {
    emit(AdminCategoryLoading());
    try {
      await adminCategoryDataSource.addCategory(category);
      emit(AdminCategoryLoaded());
    } catch (e) {
      emit(AdminCategoryError(error: e.toString()));
    }
  }

  Future updateCategory(String oldName, String newName) async {
    emit(AdminCategoryLoading());
    try {
      await adminCategoryDataSource.updateCategoryName(oldName, newName);
      emit(AdminCategoryLoaded());
    } catch (e) {
      emit(AdminCategoryError(error: e.toString()));
    }
  }

  Future deleteCategory(String category) async {
    emit(AdminCategoryLoading());
    try {
      await adminCategoryDataSource.deleteCategory(category);
      emit(AdminCategoryLoaded());
    } catch (e) {
      emit(AdminCategoryError(error: e.toString()));
    }
  }
}
