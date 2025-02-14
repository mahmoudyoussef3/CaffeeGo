// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class OrderStateChart extends StatelessWidget {
//   final int completedOrders;
//   final int canceledOrders;
//
//   const OrderStateChart(
//       {super.key, required this.completedOrders, required this.canceledOrders});
//
//   @override
//   Widget build(BuildContext context) {
//     List<_ChartData> chartData = [
//       _ChartData("Completed", completedOrders, Colors.blue),
//       _ChartData("Canceled", canceledOrders, Colors.red),
//     ];
//
//     return Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             Text(
//               "Completed vs Canceled",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             SfCircularChart(
//               legend: Legend(isVisible: true, position: LegendPosition.bottom),
//               series: <CircularSeries>[
//                 PieSeries<_ChartData, String>(
//                   dataSource: chartData,
//                   xValueMapper: (_ChartData data, _) => data.label,
//                   yValueMapper: (_ChartData data, _) => data.value,
//                   dataLabelMapper: (_ChartData data, _) => '${data.value}',
//                   pointColorMapper: (_ChartData data, _) => data.color,
//                   dataLabelSettings: DataLabelSettings(
//                     isVisible: true,
//                     labelPosition: ChartDataLabelPosition.outside,
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _ChartData {
//   final String label;
//   final int value;
//   final Color color;
//
//   _ChartData(this.label, this.value, this.color);
// }
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/utils/app_colors.dart';

class OrderStateChart extends StatelessWidget {
  final int completedOrders;
  final int canceledOrders;
  final int pendingOrders;
  final int inProgressOrders;

  const OrderStateChart(
      {super.key,
      required this.completedOrders,
      required this.canceledOrders,
      required this.pendingOrders,
      required this.inProgressOrders});

  @override
  Widget build(BuildContext context) {
    int totalOrders =
        completedOrders + canceledOrders + pendingOrders + inProgressOrders;

    double completedPercentage =
        totalOrders == 0 ? 0 : (completedOrders / totalOrders) * 100;
    double canceledPercentage =
        totalOrders == 0 ? 0 : (canceledOrders / totalOrders) * 100;
    double pendingPercentage =
        totalOrders == 0 ? 0 : (pendingOrders / totalOrders) * 100;
    double inProgressPercentage =
        totalOrders == 0 ? 0 : (inProgressOrders / totalOrders) * 100;

    List<ChartData> chartData = [
      ChartData("Completed- $completedOrders", completedPercentage.toDouble(),
          Color(0xff543A14)),
      ChartData("In Progress- $inProgressOrders",
          inProgressPercentage.toDouble(), AppColors.brownAppColor),
      ChartData("Canceled- $canceledOrders", canceledPercentage.toDouble(),
          Color(0xffF0BB78)),
      ChartData("Pending- $pendingOrders", pendingPercentage.toDouble(),
          Color(0xff131010)),
    ];

    return Center(
      child: SizedBox(
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 12,
              ),
              Text(
                "State of the orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    isResponsive: true,
                    position: LegendPosition.bottom,
                  ),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelMapper: (ChartData data, _) => data.x,
                      radius: '50%', // Make it a perfect circle
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
