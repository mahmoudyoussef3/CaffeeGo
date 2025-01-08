import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/build_coffe-items_list.dart';
import '../widgets/build_promo.dart';
import '../widgets/categories_toggle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context
        .read<CategoryCubit>()
        .getUsername(FirebaseAuth.instance.currentUser!.uid);
    return SafeArea(
        child: Scaffold(
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  DrawerHeader(
                      child: Row(children: [
                    SizedBox(
                      height: 125,
                      child: Image.asset('assets/images/app_img.png'),
                    ),
                    const Text(
                      'CaféGo',
                      style: TextStyle(
                        color: AppColors.brownAppColor,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ])),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, AppStrings.cart),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.brownAppColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: const ListTile(
                        leading: Icon(
                          Icons.shopping_cart,
                          color: AppColors.offWhiteAppColor,
                        ),
                        title: Text(
                          'Cart',
                          style: TextStyle(color: AppColors.offWhiteAppColor),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, AppStrings.fav),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.brownAppColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: const ListTile(
                        leading: Icon(
                          Icons.favorite,
                          color: AppColors.offWhiteAppColor,
                        ),
                        title: Text(
                          'Favourite',
                          style: TextStyle(color: AppColors.offWhiteAppColor),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Divider(color: AppColors.greyAppColor),
                  InkWell(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushNamed(context, AppStrings.login);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.brownAppColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: AppColors.offWhiteAppColor,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(color: AppColors.offWhiteAppColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
            appBar: AppBar(
              foregroundColor: AppColors.offWhiteAppColor,
              backgroundColor: Colors.black,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BuildPromo(),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: CategoriesToggle()),
                  const BuildCoffeeItemsList(),
                ],
              ),
            )));
  }
}
