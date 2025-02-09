import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OrdersPerHourChart extends StatelessWidget {
  OrdersPerHourChart({super.key});
  final Map<int, int> ordersPerHour = {
    8: 5,
    9: 12,
    10: 30,
    11: 22,
    12: 50,
    13: 60,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text("${value.toInt()}h");
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: ordersPerHour.entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
                  .toList(),
              isCurved: true,
              color: Colors.orange,
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }
}
