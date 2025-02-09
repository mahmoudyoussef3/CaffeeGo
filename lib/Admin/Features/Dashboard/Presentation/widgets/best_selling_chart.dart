import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BestSellingChart extends StatelessWidget {
  BestSellingChart({super.key});
  final Map<String, int> productSales = {
    "Latte": 40,
    "Espresso": 30,
    "Cappuccino": 25,
    "Mocha": 35,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(productSales.keys.elementAt(value.toInt()));
                },
              ),
            ),
          ),
          barGroups: productSales.entries.map((e) {
            return BarChartGroupData(
              x: productSales.keys.toList().indexOf(e.key),
              barRods: [
                BarChartRodData(toY: e.value.toDouble(), color: Colors.green),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
