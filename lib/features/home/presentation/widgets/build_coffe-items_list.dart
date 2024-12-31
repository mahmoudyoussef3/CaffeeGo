import 'package:coffe_app/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:coffe_app/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import 'package:coffe_app/features/home/presentation/widgets/coffee_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_strings.dart';
import 'coffe_card_widget.dart';

class BuildCoffeeItemsList extends StatefulWidget {
  const BuildCoffeeItemsList({super.key});

  @override
  State<BuildCoffeeItemsList> createState() => _CoffeeItemsListState();
}

class _CoffeeItemsListState extends State<BuildCoffeeItemsList> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<CoffeeItemsCubit>().fetchCoffeeItems();
    //  context.read<CategoryCubit>().fetchCoffeeCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeItemsCubit, CoffeeItemsState>(
        builder: (context, state) {
      if (state is CoffeeItemsLoading) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return const CoffeeCardShimmer();
                }),
          ),
        );
      }
      if (state is CoffeeItemsError) {
        return Center(child: Text(state.errorMessage));
      }
      if (state is CoffeeItemsSuccess) {
        var myItems = state.items;
        return Container(
            // height: MediaQuery.of(context).size.height - 300,
            // height: MediaQuery.of(context).size.height * 3 / 4,
            color: Colors.white,
            child:
                //Row(
                // children: [
                //   Container(
                //     width: 40,
                //     decoration: const BoxDecoration(
                //         color: AppColors.secondaryBrownAppColor,
                //         borderRadius:
                //             BorderRadius.only(topRight: Radius.circular(65))),
                //     height: MediaQuery.of(context).size.height,
                //     child: BlocBuilder<CategoryCubit, CategoryState>(
                //       builder: (context, state) {
                //         log("Current state in BlocBuilder: $state");
                //         if (state is CategoryLoading) {
                //           return const CategoriesContainerShimmer();
                //         } else if (state is CategoryError) {
                //           return Text(state.errorMessage.toString());
                //         } else if (state is CategorySuccess) {
                //           var myCategories = state.myCategories;
                //           print(myCategories);
                //
                //           return SingleChildScrollView(
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children:
                //                   List.generate(myCategories.length, (index) {
                //                 final isSelected = selectedIndex == index;
                //                 return RotatedBox(
                //                   quarterTurns: 3,
                //                   child: GestureDetector(
                //                     onTap: () {
                //                       setState(() {
                //                         selectedIndex = index;
                //                         context
                //                                 .read<CoffeeItemsCubit>()
                //                                 .category =
                //                             myCategories[index]['name'];
                //                         context
                //                             .read<CoffeeItemsCubit>()
                //                             .fetchCoffeeItems();
                //                       });
                //                     },
                //                     child: Container(
                //                       margin: const EdgeInsets.symmetric(
                //                           horizontal: 8),
                //                       padding: const EdgeInsets.symmetric(
                //                           horizontal: 16, vertical: 8),
                //                       child: Text(
                //                         myCategories[index]['name'],
                //                         style: TextStyle(
                //                           color: isSelected
                //                               ? Colors.white
                //                               : AppColors.semiBlackAppColor,
                //                           fontWeight: isSelected
                //                               ? FontWeight.bold
                //                               : FontWeight.normal,
                //                           fontSize: 18,
                //                         ),
                //                         overflow: TextOverflow.ellipsis,
                //                       ),
                //                     ),
                //                   ),
                //                 );
                //               }),
                //             ),
                //           );
                //         }
                //         return const SizedBox.shrink();
                //       },
                //     ),
                //   ),
                //   const SizedBox(
                //     width: 15,
                //   ),
                Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 2,
                // width: MediaQuery.of(context).size.width - 60,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: myItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AppStrings.itemDetails,
                              arguments: myItems[index]),
                          child: CoffeCardWidget(cardModel: myItems[index]));
                    }),
                //   ),
                // ],
              ),
            ));
      }
      return const SizedBox.shrink();
    });
  }
}
