import 'package:coffe_app/Admin/Features/Dashboard/Presentation/widgets/order_state.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/dashboard_cubit.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
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
          title: Text(
            'Analytics',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: AppColors.offWhiteAppColor,
          foregroundColor: Colors.black),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const CustomLoadingProgress();
          } else if (state is DashboardError) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          } else if (state is DashboardLoaded) {
            return SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderStateChart(
                    completedOrders:
                        state.completedOrdersToCancelled['Completed']!,
                    canceledOrders:
                        state.completedOrdersToCancelled['Canceled']!,
                    pendingOrders: state.completedOrdersToCancelled['Pending']!,
                    inProgressOrders:
                        state.completedOrdersToCancelled['In Progress']!,
                  ),
                  SizedBox(height: 5),
                  // Divider(
                  //   color: AppColors.brownAppColor,
                  //   height: 5,
                  //   endIndent: 30,
                  //   thickness: 2,
                  //   indent: 30,
                  // ),
                  SizedBox(height: 5),
                  _buildSummaryCard(
                    title: 'Total Sales',
                    value: state.totalSales.toString(),
                    icon: Icons.monetization_on,
                  ),
                  SizedBox(height: 5),
                  // Divider(
                  //   color: AppColors.brownAppColor,
                  //   height: 5,
                  //   endIndent: 30,
                  //   thickness: 2,
                  //   indent: 30,
                  // ),
                  SizedBox(height: 5),
                  _buildSummaryCard(
                    title: 'Payment Methods',
                    value:
                        "Online: ${state.paymentMethodStats['online']}\nCash: ${state.paymentMethodStats['cash']}",
                    icon: Icons.credit_card,
                  ),
                  SizedBox(height: 5),

                  SizedBox(height: 5),
                  _buildChartSection(state.ordersPerHour),
                  SizedBox(height: 5),

                  SizedBox(height: 5),
                  _buildTopProducts(state.topProducts),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.brownAppColor,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildChartSection(Map<int, int> data) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.brownAppColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Orders per Hour",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.offWhiteAppColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: data.entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.toDouble(),
                          color: AppColors.brownAppColor,
                          width: 16,
                        ),
                      ],
                    );
                  }).toList(),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProducts(Map<String, num> products) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.brownAppColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Top Products",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.offWhiteAppColor),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: products.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key, style: TextStyle(fontSize: 16)),
                  trailing: Text("${entry.value}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  subtitle: Divider(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPieChart() {
    return Container(
      height: 100,
      width: 100,
      child: PieChart(PieChartData()

          // data: [
          //   PieChartData(
          //     value: 30,
          //     hole: 0.5,
          //     color: Colors.blue,
          //     holeColor: Colors.black54,
          //     center: PieChartCenter(
          //       text: 'Online',
          //       textStyle: TextStyle(fontSize: 14),
          //     ),
          //   ),
          //   PieChartData(
          //     value: 70,
          //     hole: 0.5,
          //     color: Colors.green,
          //     holeColor: Colors.black54,
          //     center: PieChartCenter(
          //       text: 'Cash',
          //       textStyle: TextStyle(fontSize: 14),
          //     ),
          //   ),
          // ],
          ),
    );
  }
}
