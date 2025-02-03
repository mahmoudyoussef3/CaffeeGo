import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhiteAppColor,
      appBar: AppBar(
        foregroundColor: AppColors.offWhiteAppColor,
        centerTitle: true,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.brownAppColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(
              context,
              icon: Icons.coffee,
              title: 'Manage Items',
              color: AppColors.brownAppColor,
              onTap: () {
                Navigator.pushNamed(context, AppStrings.manageItems);
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.folder,
              title: 'Manage Categories',
              color: AppColors.brownAppColor,
              onTap: () {
                Navigator.pushNamed(context, AppStrings.manageCategories);
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.telegram_sharp,
              title: 'Orders',
              color: AppColors.brownAppColor,
              onTap: () {
                Navigator.pushNamed(context, AppStrings.manageOrders);
              },
            ),
            _buildDashboardCard(
              context,
              icon: Icons.person,
              title: 'User Management',
              color: AppColors.brownAppColor,
              onTap: () {
                Navigator.pushNamed(context, AppStrings.manageUsers);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
