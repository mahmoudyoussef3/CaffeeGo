import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import 'build_drawer_containers.dart';

class MyHomeScreenDrawer extends StatelessWidget {
  const MyHomeScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColorsDarkTheme.darkBlueAppColor,
      child: Column(
        children: [
          DrawerHeader(
              child: Row(children: [
            SizedBox(
              height: 125.h,
              child: Image.asset('assets/icons/playstore.png'),
            ),
            Text(
              'CaféGo',
              style: TextStyle(
                color: AppColorsDarkTheme.brownAppColor,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
              ),
            ),
          ])),
          const BuildDrawerContainers()
        ],
      ),
    );
  }
}
