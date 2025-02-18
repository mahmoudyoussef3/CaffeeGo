import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/features/home/presentation/widgets/_banner_of_home_screen_widgets/build_top_container.dart';
import 'package:coffe_app/features/home/presentation/widgets/_drawer_widgets/my_home_screen_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/_banner_of_home_screen_widgets/build_promo.dart';
import '../widgets/_coffe_item_list_widgets/build_coffe-items_list.dart';
import '../widgets/_categories_widgets/categories_toggle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            drawer: const MyHomeScreenDrawer(),
            // appBar: AppBar(
            //   backgroundColor: AppColorsDarkTheme.darkBlueAppColor,
            //   leading: IconButton(
            //     icon: Image.asset('assets/icons/drawer_icon.png'),
            //     onPressed: () {
            //       Scaffold.of(context).openDrawer();
            //     },
            //   ),
            //   actions: [
            //     IconButton(
            //       icon: CircleAvatar(
            //         foregroundColor: Colors.transparent,
            //         radius: 20.r,
            //         backgroundImage: NetworkImage(FirebaseAuth
            //                 .instance.currentUser!.photoURL ??
            //             'https://c1.klipartz.com/pngpicture/314/450/sticker-png-circle-user-profile-avatar-computer-program-symbol-oval.png'),
            //       ),
            //       onPressed: () {},
            //     )
            //   ],
            // ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.0.w, vertical: 8.h),
                    child: BuildTopContainer(),
                  ),
                  BuildPromo(),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.0.w, vertical: 24.h),
                      child: CategoriesToggle()),
                  BuildCoffeeItemsList(),
                ],
              ),
            )));
  }
}
