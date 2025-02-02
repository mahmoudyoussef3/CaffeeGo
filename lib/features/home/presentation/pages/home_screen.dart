import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/features/home/presentation/widgets/my_home_screen_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/build_coffe-items_list.dart';
import '../widgets/build_promo.dart';
import '../widgets/categories_toggle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: const MyHomeScreenDrawer(),
            appBar: AppBar(
              foregroundColor: AppColors.offWhiteAppColor,
              backgroundColor: Colors.black,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                  ),
                  onPressed: () {},
                )
              ],
            ),
            backgroundColor: Colors.white,
            body:  SingleChildScrollView(
              child: Column(
                children: [
                  BuildPromo(),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
                      child: CategoriesToggle()),
                  BuildCoffeeItemsList(),
                ],
              ),
            )));
  }
}
