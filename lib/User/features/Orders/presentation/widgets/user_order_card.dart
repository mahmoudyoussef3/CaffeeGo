import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';

class UserOrderCard extends StatelessWidget {
  final String userName;
  final String totalPrice;
  final List<Map<String, dynamic>> items;
  final DateTime orderDate;
  final String orderStatus;
  final VoidCallback onScanQr;
  final Widget qrWidget;
  final bool admin;

  const UserOrderCard({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.items,
    required this.orderDate,
    required this.orderStatus,
    required this.onScanQr,
    required this.admin,
    Widget? qrWidget,
  }) : qrWidget = qrWidget ??
      const Text(
        'Scan Qr',
        style: TextStyle(
          letterSpacing: 1,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      );

  Color getStatusColor() {
    switch (orderStatus) {
      case 'Pending':
        return AppColors.brownAppColor;
      case 'In Progress':
        return Colors.blue;
      case 'Cancelled':
        return Colors.red;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          AppColorsDarkTheme.greyAppColor,
          AppColorsDarkTheme.darkBlueAppColor,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Order Date'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateFormat('MMM d, yyyy - hh:mm').format(orderDate),
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColorsDarkTheme.greyLighterAppColor),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Total Amount'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "\$ ${totalPrice.toString()}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColorsDarkTheme.brownAppColor),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.map((item) {
                if (kDebugMode) {
                  print(item);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width:150,
                        child: Text(
                          '${item["name"]}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Text.rich(TextSpan(children: [
                        const TextSpan(
                          text: 'X ',
                          style: TextStyle(
                              color: AppColorsDarkTheme.brownAppColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${item["quantity"]}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ])),
                      Text(
                        '${item["price"]}',
                        style: const TextStyle(
                            fontSize: 16,
                            color: AppColorsDarkTheme.brownAppColor),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 95,
                  height: 30,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColorsDarkTheme.darkBlueAppColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      orderStatus,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onScanQr,
                  child: Container(
                    width: 95,
                    height: 30,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.brownAppColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: qrWidget),
                  ),
                ),

                // ElevatedButton.icon(
                //   onPressed: onScanQr,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: AppColors.brownAppColor,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8)),
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                //   ),
                //   icon: const Icon(
                //     Icons.qr_code_scanner,
                //     color: AppColors.offWhiteAppColor,
                //   ),
                //   label: const Text(
                //     'Scan QR',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w600,
                //       color: AppColors.offWhiteAppColor,
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
