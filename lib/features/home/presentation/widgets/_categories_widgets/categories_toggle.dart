import 'dart:developer';
import 'package:coffe_app/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:coffe_app/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../payment/wallet_payment.dart';
import 'categoies_container_shimmer.dart';
import 'categories_container.dart';

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
              return CategoriesContainer(
                  selectedIndex: selectedIndex, myCategories: myCategories);
            }

            return const SizedBox.shrink();
          },
        ));
  }
}
