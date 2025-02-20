import 'package:get_it/get_it.dart';
import 'package:coffe_app/Admin/Features/Categories/Data/DataSource/admin_category_data_source.dart';
import 'package:coffe_app/Admin/Features/Categories/Presentation/cubits/admin_category_cubit.dart';
import 'package:coffe_app/Admin/Features/Dashboard/Data/dashboard_repo.dart';
import 'package:coffe_app/Admin/Features/Dashboard/Data/data_source.dart';
import 'package:coffe_app/Admin/Features/Dashboard/Presentation/cubits/dashboard_cubit.dart';
import 'package:coffe_app/Admin/Features/Items/Data/DataSource/admin_items_data_source.dart';
import 'package:coffe_app/Admin/Features/Items/Data/Repo/admin_items_repo.dart';
import 'package:coffe_app/Admin/Features/Items/Presentation/cubits/admin_items_cubit.dart';
import 'package:coffe_app/Admin/Features/Orders/Data/repos/all_orders_repo.dart';
import 'package:coffe_app/Admin/Features/Orders/Presentation/cubits/get_all_users_cubit/get_all_orders_cubit.dart';
import 'package:coffe_app/Admin/Features/Users/Data/repos/all_users_repo.dart';
import 'package:coffe_app/User/features/home/data/DataSource/firebase_coffe.dart';
import 'package:coffe_app/User/features/home/data/repos/data_repo.dart';
import 'package:coffe_app/User/features/home/Domain/use_case/items_use_case.dart';
import 'package:coffe_app/User/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import 'package:coffe_app/User/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:coffe_app/User/features/cart/Data/DataSource/user_data_firebase.dart';
import 'package:coffe_app/User/features/cart/Data/repo/user_data_repo.dart';
import 'package:coffe_app/User/features/cart/Presentation/cubit/user_data_cubit.dart';

import '../User/features/Orders/Data/DataSource/user_orders_data_firebase.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => CoffeeDataSource());
  sl.registerLazySingleton(() => UserData());
  sl.registerLazySingleton(() => OrderDataFirebase());
  sl.registerLazySingleton(() => AdminCategoryDataSource());
  sl.registerLazySingleton(() => AdminItemsDataSource());
  sl.registerLazySingleton(() => DashboardAnalysis());

  sl.registerLazySingleton(() => DataRepo(coffeeDataSource: sl()));
  sl.registerLazySingleton(() => UserDataRepo(sl()));
  sl.registerLazySingleton(() => AdminItemsRepo(sl()));
  sl.registerLazySingleton(() => AllOrdersRepo());
  sl.registerLazySingleton(() => AllUsersRepo());
  sl.registerLazySingleton(() => DashboardRepo(sl()));

  sl.registerLazySingleton(() => ItemsUseCse());

  sl.registerFactory(() => CategoryCubit(sl(), sl()));
  sl.registerFactory(() => CoffeeItemsCubit(sl()));
  sl.registerFactory(() => UserDataCubit(sl()));
  sl.registerFactory(() => AdminCategoryCubit(sl()));
  sl.registerFactory(() => AdminItemsCubit(sl()));
  sl.registerFactory(() => GetAllOrdersCubit(sl()));
  sl.registerFactory(() => DashboardCubit(sl()));
}
