import 'package:coffe_app/config/routes.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'features/home/data/models/hive/hive.dart';
import 'features/home/data/models/hive/hive_item.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize Hive
  MyHive.initHive();
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
          ),
          fontFamily: 'Sora',
          textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.brownAppColor)),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AppStrings.home
          : AppStrings.home,
      debugShowCheckedModeBanner: false,
    );
  }
}
