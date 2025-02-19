import 'data_source.dart';

class DashboardRepo {
  DashboardAnalysis dashboardAnalysis;
  DashboardRepo(this.dashboardAnalysis);

  Future<Map<String, num>> getTopProducts() async {
    Map<String, num> topProducts =
        await dashboardAnalysis.getBestSellingItems();
    return topProducts;
  }

  Future<double> getTotalSales() async {
    double totalSales = await dashboardAnalysis.getTotalEarnings(
      DateTime(2022),
    );

    // await dashboardAnalysis.getTotalEarnings(DateTime.now());
    return totalSales;
  }

  Future<Map<String, int>> getCompletedOrdersToCancelled() async {
    Map<String, int> completedOrdersToCancelled =
        await dashboardAnalysis.getOrderStatusCount();
    return completedOrdersToCancelled;
  }

  Future<Map<int, int>> getOrdersPerHour() async {
    Map<int, int> ordersPerHour = await dashboardAnalysis.getOrdersPerHour();
    return ordersPerHour;
  }

  Future<Map<String, int>> getPaymentMethodStats() async {
    Map<String, int> paymentMethodStats =
        await dashboardAnalysis.getPaymentMethodStats();
    return paymentMethodStats;
  }
}
