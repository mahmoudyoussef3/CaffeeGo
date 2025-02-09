import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EarningsChart extends StatelessWidget {
  EarningsChart({super.key});
  final Map<String, dynamic> earningsData = {
    "Jan 1": 500.0,
    "Jan 2": 700.0,
    "Jan 3": 600.0,
    "Jan 4": 1200.0,
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
                  return Text(earningsData.keys.elementAt(value.toInt()));
                },
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: earningsData.entries
                  .map((e) => FlSpot(
                      earningsData.keys.toList().indexOf(e.key).toDouble(),
                      e.value))
                  .toList(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }
}
