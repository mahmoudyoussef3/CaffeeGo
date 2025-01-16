part of 'user_data_cubit.dart';

@immutable
abstract class UserDataClassState {}

class UserDataInitial extends UserDataClassState {}

class UserDataClassLoading extends UserDataClassState {}

class UserDataClassLoaded extends UserDataClassState {
  final UserDataClass userDataClass;
  UserDataClassLoaded({required this.userDataClass});
}

class UserDataClassError extends UserDataClassState {
  final String errorMessage;
  UserDataClassError({required this.errorMessage});
}
