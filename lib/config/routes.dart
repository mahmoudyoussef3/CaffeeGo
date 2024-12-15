import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/details/presentation/screen/item_details.dart';
import 'package:coffe_app/features/home/data/DataSource/firebase_coffe.dart';
import 'package:coffe_app/features/home/data/repos/data_repo.dart';
import 'package:coffe_app/features/home/presentation/pages/home_screen.dart';
import 'package:coffe_app/manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/auth/RegisterScreen/presentation/screens/register_screen.dart';
import '../features/auth/login_screen/presentation/screens/login_screen.dart';
import '../features/dash_board/presentation/pages/splash_screen.dart';
import '../features/home/presentation/cubit/coffee_cubit.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppStrings.home:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<CoffeeCubit>(
            create: (context) {


              return CoffeeCubit(
                DataRepo(coffeeDataSource: CoffeeDataSource()),
              );
            },
            child: HomeScreen(),
          );
        });

      case AppStrings.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case AppStrings.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case AppStrings.signup:
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case AppStrings.managerScreen:
        return MaterialPageRoute(builder: (context) => ManagerScreen());
      case AppStrings.itemDetails:
        return MaterialPageRoute(builder: (context) => ItemDetails());
      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
