import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/features/home/presentation/cubit/coffee_cubit.dart';
import 'package:coffe_app/features/home/presentation/widgets/categoies_container_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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
    context.read<CoffeeCubit>().fetchCoffeeCategories();
  }

  @override
  Widget build(BuildContext context) {
    var myCubitData = context.read<CoffeeCubit>().coffeeCategories;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<CoffeeCubit, CoffeeState>(
        builder: (context, state) {
          if (state is CoffeeLoading) {
            return CategoriesContainerShimmer();
          }
          if (state is CoffeeError) {
            return Text(state.errorMessage.toString());
          }
          if (state is CoffeeSuccess) {
            return Row(
              children: List.generate(myCubitData.length, (index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.brownAppColor
                          : AppColors.greyAppColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      myCubitData[index]['name'],
                      style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 16),
                    ),
                  ),
                );
              }),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
