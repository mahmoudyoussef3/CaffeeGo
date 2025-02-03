part of 'get_all_orders_cubit.dart';

@immutable
sealed class GetAllOrdersState {}

final class GetAllOrdersInitial extends GetAllOrdersState {}

final class GetAllOrdersLoading extends GetAllOrdersState {}

final class GetAllOrdersSuccess extends GetAllOrdersState {
  final List<OrderModel> orders;

  GetAllOrdersSuccess({required this.orders});
}

final class GetAllOrdersFailure extends GetAllOrdersState {
  final String error;

  GetAllOrdersFailure({required this.error});
}
