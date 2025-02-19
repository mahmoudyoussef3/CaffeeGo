
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/dashboard_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepo dashboardRepo;

  DashboardCubit(this.dashboardRepo) : super(DashboardInitial());

  Future<void> fetchDashboardData() async {
    emit(DashboardLoading());
    try {
      final topProducts = await dashboardRepo.getTopProducts();
      final totalSales = await dashboardRepo.getTotalSales();
      final completedOrdersToCancelled =
          await dashboardRepo.getCompletedOrdersToCancelled();
      final ordersPerHour = await dashboardRepo.getOrdersPerHour();
      final paymentMethodStats = await dashboardRepo.getPaymentMethodStats();

      emit(DashboardLoaded(
        topProducts: topProducts,
        totalSales: totalSales,
        completedOrdersToCancelled: completedOrdersToCancelled,
        ordersPerHour: ordersPerHour,
        paymentMethodStats: paymentMethodStats,
      ));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
