part of 'admin_category_cubit.dart';

@immutable
sealed class AdminCategoryState {}

final class AdminCategoryInitial extends AdminCategoryState {}

class AdminCategoryLoading extends AdminCategoryState {}

class AdminCategoryError extends AdminCategoryState {
  final String error;
  AdminCategoryError({required this.error});
}

class AdminCategoryLoaded extends AdminCategoryState {
  AdminCategoryLoaded();
}
