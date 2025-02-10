import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/widgets/custom_loading_progress.dart';
import '../cubits/dashboard_cubit.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().fetchDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('📊 Dashboard',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.brownAppColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CustomLoadingProgress());
          } else if (state is DashboardError) {
            return Center(
                child: Text(state.message,
                    style: TextStyle(fontSize: 18, color: Colors.red)));
          } else if (state is DashboardLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      children: [
                        _buildStatCard(
                            'Total Sales',
                            state.totalSales.toString(),
                            Icons.monetization_on,
                            Colors.green),
                        _buildStatCard(
                            'Completed vs Canceled',
                            "Completed :${state.completedOrdersToCancelled['Completed']}\nCanceled :${state.completedOrdersToCancelled['Canceled']}",
                            Icons.check_circle,
                            Colors.blue),
                        _buildChartCard('Orders per Hour', state.ordersPerHour),
                        _buildStatCard(
                            'Payment Methods',
                            "Online :${state.paymentMethodStats['online']}\nCash :${state.paymentMethodStats['cash']}",
                            Icons.credit_card,
                            Colors.purple),
                        _buildTopProductsCard(state.topProducts)
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(value,
                style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProductsCard(Map<String, num> topProducts) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.coffee, size: 40, color: Colors.orange),
            SizedBox(height: 10),
            Text('Top Products',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            ...topProducts.entries.map((entry) => Text(
                  '${entry.key}: ${entry.value}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard(String title, Map<int, int> data) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: data.entries.map((e) {
                    return BarChartGroupData(
                      x: e.key,
                      barRods: [
                        BarChartRodData(
                            toY: e.value.toDouble(),
                            color: Colors.blue,
                            width: 15)
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
