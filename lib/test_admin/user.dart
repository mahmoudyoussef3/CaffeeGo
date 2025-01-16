// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:coffe_app/test_admin/admin.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   runApp( UserApp());
// //   // runApp(const CoffeeShopApp());
// // }
// class UserApp extends StatelessWidget {
//   const UserApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'User App',
//       theme: ThemeData(primarySwatch: Colors.green),
//       home: const UserHomeScreen(), // Initial screen
//     );
//   }
// }
//
// class UserHomeScreen extends StatefulWidget {
//   const UserHomeScreen({super.key});
//
//   @override
//   State<UserHomeScreen> createState() => _UserHomeScreenState();
// }
//
// class _UserHomeScreenState extends State<UserHomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     initPlatform();
//   }
//
//   Future<void> initPlatform() async {
//     await OneSignal.shared.setAppId('3e076dbf-8eba-4b5e-840d-4d24f7980010');
//     await OneSignal.shared
//         .promptUserForPushNotificationPermission(fallbackToSettings: true);
//
//     const externalUserId = 'hhfjfjfj35@gmail.com';
//     if (externalUserId.isNotEmpty) {
//       await OneSignal.shared.setExternalUserId(externalUserId).then((value) {
//         log('External User ID Set: $externalUserId');
//       });
//     } else {
//       await OneSignal.shared.setExternalUserId(externalUserId).then((value) {
//         log('External User ID Cleared');
//       });
//     }
//
//     await OneSignal.shared.getDeviceState().then((value) {
//       log('Device User ID: ${value?.userId}');
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('User Home')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) {
//                     return const AdminDashboard(); // Navigate to Admin
//                   }),
//                 );
//               },
//               child: const Text('Admin Dashboard'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
