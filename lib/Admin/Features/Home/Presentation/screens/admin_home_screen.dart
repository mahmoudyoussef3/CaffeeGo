import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../widgets/dashboard_card.dart';

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
            Hero(
              tag: 'manage_items',
              child: DashboardCard(
                title: 'Manage Items',
                onTap: () =>
                    Navigator.pushNamed(context, AppStrings.manageItems),
                icon: Icons.coffee,
                color: AppColors.brownAppColor,
              ),
            ),
            Hero(
              tag: 'manage_categories',
              child: DashboardCard(
                title: 'Manage Categories',
                onTap: () =>
                    Navigator.pushNamed(context, AppStrings.manageCategories),
                icon: Icons.folder,
                color: AppColors.brownAppColor,
              ),
            ),
            Hero(
              tag: 'orders',
              child: DashboardCard(
                title: 'Orders',
                onTap: () =>
                    Navigator.pushNamed(context, AppStrings.manageOrders),
                icon: Icons.shopping_cart,
                color: AppColors.brownAppColor,
              ),
            ),
            Hero(
              tag: 'user_management',
              child: DashboardCard(
                title: 'User Management',
                onTap: () =>
                    Navigator.pushNamed(context, AppStrings.manageUsers),
                icon: Icons.person,
                color: AppColors.brownAppColor,
              ),
            ),
            Hero(
              tag: 'analytics',
              child: DashboardCard(
                title: 'Analytics',
                onTap: () => Navigator.pushNamed(
                    context, AppStrings.manageDashboardData),
                icon: Icons.analytics,
                color: AppColors.brownAppColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
