import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ManageItemsScreen extends StatelessWidget {
  const ManageItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Manage Items'),
          backgroundColor: AppColors.brownAppColor),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10, // Replace with your dynamic data
        itemBuilder: (context, index) {
          return _buildItemCard(
              context, 'Item Name $index', 'Description for item $index');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addItem');
        },
        backgroundColor: AppColors.brownAppColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemCard(
      BuildContext context, String title, String description) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const Icon(Icons.coffee, color: AppColors.brownAppColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.pushNamed(context, '/editItem');
            } else if (value == 'delete') {
              // Handle delete logic here
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
