part of 'admin_items_cubit.dart';

@immutable
sealed class AdminItemsState {}

final class AdminItemsInitial extends AdminItemsState {}

class AdminItemsLoading extends AdminItemsState {}

class AdminItemsError extends AdminItemsState {
  final String errorMessage;
  AdminItemsError({required this.errorMessage});
}

class AdminItemsLoaded extends AdminItemsState {}
