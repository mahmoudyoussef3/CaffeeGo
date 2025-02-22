import 'package:coffe_app/Admin/Features/AdminNotification/data/admin_notifications.dart';
import 'package:coffe_app/config/routes.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/notifications.dart/notification_config.dart';
import '../core/utils/app_colors.dart';
import '../firebase_options.dart';
import 'Features/Home/Presentation/screens/admin_home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MessagingConfig.initFirebaseMessaging();
  FirebaseMessaging.instance.getToken().then(
        (value) => print("valueis \"$value\""),
      );

  runApp(const AdminApp());
  Future.delayed(
      const Duration(seconds: 2), () => FlutterNativeSplash.remove());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then((value) => print("value$value"));
    return MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.offWhiteAppColor,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
            ),
            fontFamily: 'Poppins',
            textSelectionTheme: const TextSelectionThemeData(
                cursorColor: AppColors.brownAppColor)),
        onGenerateRoute: AppRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        home: const AdminHomeScreen());
  }
}
