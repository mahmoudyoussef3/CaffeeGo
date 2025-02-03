// import 'package:coffe_app/Admin/Features/Home/Presentation/screens/admin_home_screen.dart';
// import 'package:coffe_app/Admin/Features/Orders/Presentation/screens/user_orders_screen.dart';
// import 'package:coffe_app/core/utils/app_colors.dart';
// import 'package:flutter/material.dart';
//
// import 'Features/Users/Presentation/screens/users_screen.dart';
//
// class AdminScreenManager extends StatefulWidget {
//   const AdminScreenManager({super.key});
//
//   @override
//   State<AdminScreenManager> createState() => _AdminScreenManagerState();
// }
//
// class _AdminScreenManagerState extends State<AdminScreenManager> {
//   int _currentIndex = 0;
//   List myScreens = const [
//     AdminHomeScreen(),
//     AdminHomeScreen(),
//     AdminHomeScreen()
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//           selectedItemColor: AppColors.offWhiteAppColor,
//           backgroundColor: AppColors.brownAppColor,
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.coffee), label: 'Orders'),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Users'),
//           ],
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             _currentIndex = index;
//             print(_currentIndex);
//             setState(() {});
//           }),
//       body: myScreens[_currentIndex],
//     );
//   }
// }
