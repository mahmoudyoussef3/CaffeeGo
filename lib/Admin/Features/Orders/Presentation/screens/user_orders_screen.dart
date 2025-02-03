import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class ManageOrdersScreen extends StatelessWidget {
  const ManageOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          foregroundColor: AppColors.offWhiteAppColor,
          title: const Text('Manage Orders'),
          backgroundColor: AppColors.brownAppColor),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 12, // Replace with your dynamic data
        itemBuilder: (context, index) {
          return _buildOrderCard(context, 'Order #$index', 'Pending');
        },
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, String orderId, String status) {
    Color statusColor = status == 'Pending'
        ? Colors.orange
        : status == 'Completed'
            ? Colors.green
            : Colors.red;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const Icon(Icons.coffee, color: AppColors.brownAppColor),
        title:
            Text(orderId, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Status: $status', style: TextStyle(color: statusColor)),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'view') {
              Navigator.pushNamed(context, '/viewOrder');
            } else if (value == 'update') {
              // Handle update status logic here
            } else if (value == 'delete') {
              // Handle delete logic here
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'view', child: Text('View Details')),
            const PopupMenuItem(value: 'update', child: Text('Update Status')),
            const PopupMenuItem(value: 'delete', child: Text('Delete Order')),
          ],
        ),
      ),
    );
  }
}
