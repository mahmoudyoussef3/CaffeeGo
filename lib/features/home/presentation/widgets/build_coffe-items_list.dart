import 'package:coffe_app/features/details/presentation/screen/item_details.dart';
import 'package:coffe_app/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'package:coffe_app/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import 'package:coffe_app/features/home/presentation/widgets/coffee_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/widgets/custom_loading_progress.dart';
import '../../../payment/wallet_payment.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<CoffeeItemsCubit, CoffeeItemsState>(
        builder: (context, state) {
      if (state is CoffeeItemsLoading) {
        return   Center(child: CustomLoadingProgress());

      }
      if (state is CoffeeItemsError) {
        return Center(child: Text(state.errorMessage));
      }
      if (state is CoffeeItemsSuccess) {
        var myItems = state.items;
        return Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: SizedBox(
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ItemDetails(coffeeItem: myItems[index]),
                                ));
                          },
                          child: CoffeeCardWidget(cardModel: myItems[index]));
                    }),
              ),
            ));
      }
      return const SizedBox.shrink();
    });
  }
}
