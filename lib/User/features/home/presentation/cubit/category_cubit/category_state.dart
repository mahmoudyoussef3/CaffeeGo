part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class UserNameDone extends CategoryState {
  final String userName;
  UserNameDone(this.userName);
}

class UserNameLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List myCategories;
  CategorySuccess(this.myCategories);
}

class CategoryError extends CategoryState {
  final String errorMessage;

  CategoryError({required this.errorMessage});
}
