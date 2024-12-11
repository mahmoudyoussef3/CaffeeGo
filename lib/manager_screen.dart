import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/features/cart/screen/cart_screen.dart';
import 'package:coffe_app/features/fav/screen/fav_screen.dart';
import 'package:coffe_app/features/home/presentation/pages/home_screen.dart';
import 'package:coffe_app/features/notification/screen/notification_screen.dart';
import 'package:flutter/material.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({super.key});

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  int _selectedTab = 0;
  List<Widget> myScreens = [
    HomeScreen(),
    FavScreen(),
    CartScreen(),
    NotificationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.home),
                    Divider(
                      color: AppColors.brownAppColor,
                      thickness: 3,
                      indent: 40,
                      endIndent: 40,
                      height: 2,

                    )
                  ],
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.favorite),
                    Divider(
                      color: AppColors.brownAppColor,
                      thickness: 3,
                      indent: 40,
                      endIndent: 40,
                      height: 2,
                    )
                  ],
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.card_travel),
                    Divider(
                      color: AppColors.brownAppColor,
                      thickness: 3,
                      indent: 40,
                      endIndent: 40,
                      height: 2,
                    )
                  ],
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.notifications),
                    Divider(
                      color: AppColors.brownAppColor,
                      thickness: 3,
                      indent: 40,
                      endIndent: 40,
                      height: 2,
                    )
                  ],
                ),
                label: ''),
          ],
          selectedItemColor: AppColors.brownAppColor,
          unselectedItemColor: Colors.black45,
          currentIndex: _selectedTab,
          onTap: (index) {
            setState(() {
              _selectedTab = index;
            });
          }),
      body: myScreens[_selectedTab],
    );
  }
}
