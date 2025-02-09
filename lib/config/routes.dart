import 'package:coffe_app/Admin/Features/Categories/Data/DataSource/admin_category_data_source.dart';
import 'package:coffe_app/Admin/Features/Categories/Presentation/cubits/admin_category_cubit.dart';
import 'package:coffe_app/Admin/Features/Categories/Presentation/screens/Categories.dart';
import 'package:coffe_app/Admin/Features/Items/Data/DataSource/admin_items_data_source.dart';
import 'package:coffe_app/Admin/Features/Items/Data/Repo/admin_items_repo.dart';
import 'package:coffe_app/Admin/Features/Items/Presentation/cubits/admin_items_cubit.dart';
import 'package:coffe_app/Admin/Features/Items/Presentation/screens/add_item.dart';
import 'package:coffe_app/Admin/Features/Orders/Data/repos/all_orders_repo.dart';
import 'package:coffe_app/Admin/Features/Orders/Presentation/cubits/get_all_users_cubit/get_all_orders_cubit.dart';
import 'package:coffe_app/Admin/Features/Users/Data/repos/all_users_repo.dart';
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
import '../Admin/Features/Items/Presentation/screens/Items.dart';
import '../Admin/Features/Orders/Presentation/screens/user_orders_screen.dart';
import '../Admin/Features/Users/Presentation/cubits/get_all_users_cubit/get_all_users_cubit.dart';
import '../Admin/Features/Users/Presentation/screens/users_screen.dart';
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
                    BlocProvider(create: (context) => (UserDataClassCubit())),
                  ],
                  child: const CartScreen(),
                ));

      case AppStrings.onBoarding:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());

      case AppStrings.fav:
        return MaterialPageRoute(builder: (context) => const FavScreen());

      case AppStrings.orderHistory:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      OrdersCubit(UserOrdersRepo(OrderDataFirebase())),
                  child: OrderScreen(),
                ));
      case AppStrings.manageCategories:
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
              create: (context) =>
                  AdminCategoryCubit(AdminCategoryDataSource()),
            ),
          ], child: const ManageCategoriesScreen()),
        );
      case AppStrings.manageItems:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => CoffeeItemsCubit(ItemsUseCse()),
            ),
            BlocProvider(
                create: (
              context,
            ) =>
                    CategoryCubit(
                        DataRepo(coffeeDataSource: CoffeeDataSource()),
                        ItemsUseCse())),
          ], child: const ManageItemsScreen()),
        );
      case AppStrings.addItems:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (context) => CoffeeItemsCubit(ItemsUseCse()),
            ),
            BlocProvider(
                create: (
              context,
            ) =>
                    CategoryCubit(
                        DataRepo(coffeeDataSource: CoffeeDataSource()),
                        ItemsUseCse())),
            BlocProvider(
                create: (context) =>
                    (AdminItemsCubit(AdminItemsRepo(AdminItemsDataSource())))),
          ], child: const AddCoffeeItemScreen()),
        );
      case AppStrings.manageOrders:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GetAllOrdersCubit(AllOrdersRepo()),
                  child: ManageOrdersScreen(),
                ));
      case AppStrings.manageUsers:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => GetAllUsersCubit(AllUsersRepo()),
                  child: ManageUsersScreen(),
                ));

      default:
        return MaterialPageRoute(builder: (context) => LoginScreen());
    }
  }
}
