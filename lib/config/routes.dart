import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/Onboarding/screens/onboarding_screen.dart';
import 'package:coffe_app/features/Orders/Data/DataSource/user_orders_data_firebase.dart';
import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/Orders/Data/repo/user_orders_repo.dart';
import 'package:coffe_app/features/Orders/presentation/cubits/order_cubit/orders_cubit.dart';
import 'package:coffe_app/features/cart/Data/DataSource/user_data_firebase.dart';
import 'package:coffe_app/features/cart/Data/repo/user_data_repo.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/home/Domain/use_case/items_use_case.dart';
import 'package:coffe_app/features/home/data/repos/data_repo.dart';
import 'package:coffe_app/features/home/presentation/cubit/UserData_cubit/user_data_cubit.dart';
import 'package:coffe_app/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:coffe_app/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import 'package:coffe_app/features/home/presentation/pages/home_screen.dart';
import 'package:coffe_app/features/payment/cubit/payment_cubit.dart';
import 'package:coffe_app/manager_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/Orders/presentation/screens/order_screen.dart';
import '../features/auth/RegisterScreen/presentation/screens/register_screen.dart';
import '../features/auth/login_screen/presentation/screens/login_screen.dart';
import '../features/cart/Presentation/screen/cart_screen.dart';
import '../features/fav/Presentation/screen/fav_screen.dart';
import '../features/home/data/DataSource/firebase_coffe.dart';
import '../features/splash/screen/splash_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppStrings.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider(
                create: (
              context,
            ) =>
                    CategoryCubit(
                        DataRepo(coffeeDataSource: CoffeeDataSource()),
                        ItemsUseCse())),
            BlocProvider(
                create: (context) => UserDataCubit(UserDataRepo(UserData()))),
            BlocProvider(
              create: (context) => CoffeeItemsCubit(ItemsUseCse()),
            ),
            BlocProvider(create: (context) => (UserDataClassCubit())),
            BlocProvider(create: (context) => (PaymentCubit()))
          ], child: const HomeScreen()),
        );
      case AppStrings.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppStrings.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case AppStrings.signup:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case AppStrings.managerScreen:
        return MaterialPageRoute(builder: (context) => const ManagerScreen());
      case AppStrings.cart:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => UserDataCubit(
                        UserDataRepo(UserData()),
                      ),
                    ),
                    BlocProvider(create: (context) => PaymentCubit()),
                    BlocProvider(
                      create: (context) => OrdersCubit(
                        UserOrdersRepo(OrderDataFirebase()),
                      ),
                    ),
                  ],
                  child: const CartScreen(),
                ));

      case AppStrings.onBoarding:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());

      // case AppStrings.itemDetails:
      //   final CoffeeItem? args = settings.arguments as CoffeeItem?;
      //   log("${args!.description}  ======  item details");
      //   return MaterialPageRoute(
      //       settings: RouteSettings(arguments: args),
      //       builder: (context) {
      //         return MultiBlocProvider(
      //           providers: [
      //             BlocProvider(
      //                 create: (context) => CategoryCubit(
      //                     DataRepo(coffeeDataSource: CoffeeDataSource()),
      //                     ItemsUseCse())),
      //             BlocProvider(
      //                 create: (context) =>
      //                     UserDataCubit(UserDataRepo(UserData()))),
      //             BlocProvider(
      //               create: (context) => CoffeeItemsCubit(ItemsUseCse()),
      //             )
      //           ],
      //           child: ItemDetails(
      //             coffeeItem: args,
      //           ),
      //         );
      //       });
      case AppStrings.fav:
        return MaterialPageRoute(builder: (context) => const FavScreen());

      case AppStrings.orderHistory:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      OrdersCubit(UserOrdersRepo(OrderDataFirebase())),
                  child: OrderScreen(
                    qrData: 'Test',
                  ),
                ));
      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
