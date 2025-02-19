part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final Map<String, num> topProducts;
  final double totalSales;
  final Map<String, int> completedOrdersToCancelled;
  final Map<int, int> ordersPerHour;
  final Map<String, int> paymentMethodStats;

  DashboardLoaded({
    required this.topProducts,
    required this.totalSales,
    required this.completedOrdersToCancelled,
    required this.ordersPerHour,
    required this.paymentMethodStats,
  });

  List<Object> get props => [
    topProducts,
    totalSales,
    completedOrdersToCancelled,
    ordersPerHour,
    paymentMethodStats,
  ];
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);

  List<Object> get props => [message];
}