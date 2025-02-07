import 'package:coffe_app/Admin/Features/AdminNotification/data/admin_notifications.dart';
import 'package:coffe_app/config/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../core/utils/app_colors.dart';
import '../firebase_options.dart';
import 'Features/Home/Presentation/screens/admin_home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await OneSignalAdmin().initPlatform();

  runApp(const AdminApp());
  Future.delayed(Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.offWhiteAppColor,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
            ),
            fontFamily: 'Sora',
            textSelectionTheme: const TextSelectionThemeData(
                cursorColor: AppColors.brownAppColor)),
        onGenerateRoute: AppRouter.onGenerateRoute,
        debugShowCheckedModeBanner: false,
        home: const AdminHomeScreen());
  }
}
