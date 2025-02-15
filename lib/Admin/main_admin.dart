import 'package:coffe_app/Admin/Features/AdminNotification/data/admin_notifications.dart';
import 'package:coffe_app/config/routes.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../core/utils/app_colors.dart';
import '../firebase_options.dart';
import 'Features/Home/Presentation/screens/admin_home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await OneSignalAdmin().initPlatform();
  OneSignal.shared
      .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    print("OPENED NOTIFICATION");
    String? deepLink = result.notification.launchUrl;
    if (deepLink != null) {
      print("Deep link: $deepLink");
    }
    handleDeepLink(deepLink!);
  });
  OneSignal.shared.setLaunchURLsInApp(true);

  runApp(const AdminApp());
  Future.delayed(Duration(seconds: 2), () {
    FlutterNativeSplash.remove();
  });
}

void handleDeepLink(String deepLink) {
  print('start handeleDeepLink');
  if (deepLink.startsWith('myapp://order/')) {
    String orderId = deepLink.substring(14);
    print("Order ID: $orderId");
    navigatorKey.currentState?.pushNamed(
      AppStrings.manageOrders,
    );
  }
}

void showToastMsg(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
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
