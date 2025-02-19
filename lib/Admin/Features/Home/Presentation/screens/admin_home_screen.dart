import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/grid_painter.dart';

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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: GridPainter(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                DashboardCard(
                  title: 'Drinks',
                  onTap: () =>
                      Navigator.pushNamed(context, AppStrings.manageItems),
                  icon: Icons.coffee,
                  color: AppColors.brownAppColor,
                ),
                DashboardCard(
                  title: 'Categories',
                  onTap: () =>
                      Navigator.pushNamed(context, AppStrings.manageCategories),
                  icon: Icons.folder,
                  color: AppColors.brownAppColor,
                ),
                DashboardCard(
                  title: 'Orders',
                  onTap: () =>
                      Navigator.pushNamed(context, AppStrings.manageOrders),
                  icon: Icons.shopping_cart,
                  color: AppColors.brownAppColor,
                ),
                DashboardCard(
                  title: 'Users',
                  onTap: () =>
                      Navigator.pushNamed(context, AppStrings.manageUsers),
                  icon: Icons.person,
                  color: AppColors.brownAppColor,
                ),
                DashboardCard(
                  title: 'Analytics',
                  onTap: () => Navigator.pushNamed(
                      context, AppStrings.manageDashboardData),
                  icon: Icons.analytics,
                  color: AppColors.brownAppColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
