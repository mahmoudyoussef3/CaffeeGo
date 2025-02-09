import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PaymentMethodPieChart extends StatelessWidget {
  PaymentMethodPieChart({super.key});
  final Map<String, int> paymentData = {
    "Online": 80,
    "Cash": 20,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sections: paymentData.entries.map((e) {
            return PieChartSectionData(
              value: e.value.toDouble(),
              title: "${e.value}",
              color: e.key == "online" ? Colors.blue : Colors.red,
            );
          }).toList(),
        ),
      ),
    );
  }
}
