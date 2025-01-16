import 'package:coffe_app/config/routes.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/payment/cubit/payment_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/home/data/models/hive/hive.dart';
import 'firebase_options.dart';
import 'package:flutter_paymob/flutter_paymob.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterPaymob.instance.initialize(
      apiKey:
          "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBeE56RXpPQ3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS5qZUdnSnk1b2NRcUtpN1Y0SXExS0FTcGVvWm5VM2lKU1hYV0t0cnNpVUlSMy1rSm01WjhtcTkwNGdyckZ4eVFpaUc5Z0o0UFlKUXB1Z19IUHg2cWh4Zw==",
      integrationID: 4923809,
      walletIntegrationId: 4923809,
      iFrameID: 893140);
  MyHive.initHive();
  runApp(BlocProvider(
      create: (context) => PaymentCubit(), child: const CoffeeShopApp()));
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
      initialRoute: AppStrings.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
