import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class MyHomeScreenDrawer extends StatelessWidget {
  const MyHomeScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
              child: Row(children: [
            SizedBox(
              height: 125,
              child: Image.asset('assets/images/app_img.png'),
            ),
            const Text(
              'CaféGo',
              style: TextStyle(
                color: AppColors.brownAppColor,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ])),
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppStrings.cart),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.brownAppColor,
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(
                  Icons.shopping_cart,
                  color: AppColors.offWhiteAppColor,
                ),
                title: Text(
                  'Cart',
                  style: TextStyle(color: AppColors.offWhiteAppColor),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppStrings.fav),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.brownAppColor,
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: AppColors.offWhiteAppColor,
                ),
                title: Text(
                  'Favourite',
                  style: TextStyle(color: AppColors.offWhiteAppColor),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, AppStrings.orderHistory),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: AppColors.brownAppColor,
                  borderRadius: BorderRadius.circular(12)),
              child: const ListTile(
                leading: Icon(
                  Icons.coffee,
                  color: AppColors.offWhiteAppColor,
                ),
                title: Text(
                  'Orders',
                  style: TextStyle(color: AppColors.offWhiteAppColor),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Divider(color: AppColors.greyAppColor),
          InkWell(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              await GoogleSignIn().signOut();
              Navigator.pushNamed(context, AppStrings.login);
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.brownAppColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ListTile(
                leading: Icon(
                  Icons.logout,
                  color: AppColors.offWhiteAppColor,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(color: AppColors.offWhiteAppColor),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
