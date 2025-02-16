import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';

class OrderCard extends StatelessWidget {
  final String userName;
  final String totalPrice;
  final List<Map<String, dynamic>> items;
  final DateTime orderDate;
  final String orderStatus;
  final VoidCallback onScanQr;
  final Widget qrWidget;
  final bool admin;

  const OrderCard({
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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 Icon( admin ? Icons.person:Icons.coffee, size: 22, color: Colors.black87),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    userName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 95,
                  height: 30,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: getStatusColor(),
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
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Total Price: \$$totalPrice',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '- ${item["name"]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${item["quantity"]}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                Text(
                  'Date: ${DateFormat('MMM d, yyyy - hh:mm').format(orderDate)}',
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
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
