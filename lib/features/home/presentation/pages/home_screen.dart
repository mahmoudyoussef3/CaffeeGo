import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/home/presentation/widgets/build_promo.dart';
import 'package:coffe_app/features/home/presentation/widgets/categories_toggle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/coffe_card_model.dart';
import '../../data/models/coffe_item.dart';
import '../cubit/coffee_cubit.dart';
import '../widgets/coffe_card_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CoffeeCubit>();
    cubit.fetchCoffeeItems();
    log("build home screen");

    return SafeArea(
        child: Scaffold(

            backgroundColor: Colors.white,
              body: BlocBuilder<CoffeeCubit, CoffeeState>(
                builder: (context, state) {
                  log(state.toString());
                  if (state is CoffeeLoading) {
                    log("CoffeeLoading home screen");

                    return Center(child: const CircularProgressIndicator(color: AppColors.brownAppColor,));
                  }
                  if (state is CoffeeError) {
                    log("CoffeeError home screen");

                    return Text(state.errorMessage.toString());
                  }
                  if (state is FetchCoffeeItemsSuccess) {
                    log("FetchCoffeeItemsSuccess home screen");

                    return SingleChildScrollView(
                              child: Column(
                                children: [
                                  BuildPromo(),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12),
                                    child: Text("Categories",),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                    child: Container(
                                      height: 400,
                                      color: Colors.white,
                                      child: GridView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: cubit.coffeeItems.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 0.6,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () => Navigator.pushNamed(
                                                    context, AppStrings.itemDetails,arguments: cubit.coffeeItems[index]),
                                                child: CoffeCardWidget(
                                                    cardModel: cubit.coffeeItems[index]));
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                  return SizedBox();
                },
              )
            // BlocBuilder<CoffeeCubit, CoffeeState>(
            //   builder: (context, state) {
            //     if (state.s == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       ); //waiting state
            //     }
            //     if (snapshot.hasData) {
            //       List<CoffeeItem> listOfDrinks = snapshot.data!;
            //       return SingleChildScrollView(
            //         child: Column(
            //           children: [
            //             BuildPromo(),
            //             Padding(
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 16.0, vertical: 12),
            //               child: CategoriesToggle(),
            //             ),
            //             Padding(
            //               padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //               child: Container(
            //                 height: 400,
            //                 color: Colors.white,
            //                 child: GridView.builder(
            //                     physics: NeverScrollableScrollPhysics(),
            //                     itemCount: listOfDrinks.length,
            //                     gridDelegate:
            //                         const SliverGridDelegateWithFixedCrossAxisCount(
            //                       crossAxisCount: 2,
            //                       mainAxisSpacing: 10,
            //                       childAspectRatio: 0.6,
            //                       crossAxisSpacing: 10,
            //                     ),
            //                     itemBuilder: (context, index) {
            //                       return GestureDetector(
            //                           onTap: () => Navigator.pushNamed(
            //                               context, AppStrings.itemDetails,arguments: listOfDrinks[index]),
            //                           child: CoffeCardWidget(
            //                               cardModel: listOfDrinks[index]));
            //                     }),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     } else {
            //       return const Center(
            //         child: Text("Error"),
            //       );
            //     }
            //   }, // a previously-obtained Future<String> or null
            //
        ));
  }




}
