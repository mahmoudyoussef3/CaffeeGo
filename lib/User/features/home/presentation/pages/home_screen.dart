import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/_banner_of_home_screen_widgets/build_promo.dart';
import '../widgets/_banner_of_home_screen_widgets/build_top_container.dart';
import '../widgets/_coffe_item_list_widgets/build_coffe-items_list.dart';
import '../widgets/_categories_widgets/categories_toggle.dart';
import '../widgets/_drawer_widgets/my_home_screen_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: const MyHomeScreenDrawer(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 0.h),
                    child: const BuildTopContainer(),
                  ),
                  const BuildPromo(),
                  const SizedBox(height: 16,),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0.w, vertical: 8.h),
                      child: const CategoriesToggle()),
                  const BuildCoffeeItemsList(),
                ],
              ),
            )));
  }
}
