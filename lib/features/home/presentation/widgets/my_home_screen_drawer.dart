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
            onTap: () {
              Navigator.pop(context);
              buildTheDialogOfLogout(context);
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

  void buildTheDialogOfLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.grey[900],
          title: Column(
            children: [
              Icon(
                Icons.logout,
                size: 48,
                color: AppColors.brownAppColor,
              ),
              SizedBox(height: 10),
              Text(
                "Logout",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                Navigator.pushReplacementNamed(context, AppStrings.login);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Yes, Logout",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[700],
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
