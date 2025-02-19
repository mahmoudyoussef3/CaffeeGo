import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'features/Orders/presentation/screens/order_screen.dart';
import 'features/cart/Presentation/screen/cart_screen.dart';
import 'features/fav/Presentation/screen/fav_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';

class BottomNavManager extends StatefulWidget {
  const BottomNavManager({super.key});

  @override
  State<BottomNavManager> createState() => _BottomNavManagerState();
}

class _BottomNavManagerState extends State<BottomNavManager> {
  List<Widget> myScreens =const [
    HomeScreen(),
     CartScreen(),
    FavScreen(),
    OrderScreen()
  ];
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (value) {
            setState(() {
              _selectedTab = value;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColorsDarkTheme.brownAppColor,
          unselectedItemColor: AppColorsDarkTheme.greyLessDegreeAppColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_rounded), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.coffee), label: ''),
          ]),
      body: myScreens[_selectedTab],
    );
  }
}
