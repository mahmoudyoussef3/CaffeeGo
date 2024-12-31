import 'dart:developer';
import 'package:coffe_app/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:coffe_app/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../payment/wallet_payment.dart';
import 'categoies_container_shimmer.dart';

class CategoriesToggle extends StatefulWidget {
  const CategoriesToggle({super.key});

  @override
  State<CategoriesToggle> createState() => _CategoriesToggleState();
}

class _CategoriesToggleState extends State<CategoriesToggle> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCoffeeCategories();
  }

  PaymobWalletManager manager = PaymobWalletManager();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            log("Current state in BlocBuilder: $state");
            if (state is CategoryLoading) {
              return const CategoriesContainerShimmer();
            } else if (state is CategoryError) {
              return Text(state.errorMessage.toString());
            } else if (state is CategorySuccess) {
              var myCategories = state.myCategories;
              print(myCategories);
              return Row(
                children: List.generate(myCategories.length, (index) {
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        context.read<CoffeeItemsCubit>().category =
                            myCategories[index]['name'];
                        context.read<CoffeeItemsCubit>().fetchCoffeeItems();
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.brownAppColor
                            : AppColors.greyAppColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        myCategories[index]['name'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }),
              );
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
