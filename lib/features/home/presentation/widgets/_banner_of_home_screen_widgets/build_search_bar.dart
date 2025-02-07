import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../cubit/coffe_items/coffee_items_cubit.dart';


class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({super.key, required this.searchController});
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23.r),
      ),
      width: MediaQuery.of(context).size.width * 3 / 4 - 40.w,
      child: Center(
        child: SearchBar(
          controller: searchController,
          onChanged: (value) {
            context
                .read<CoffeeItemsCubit>()
                .fetchCoffeeItemsBySearch(searchController.text);

            if (kDebugMode) {
              print("Typing: $value");
            }
          },
          onSubmitted: (query) {
            if (kDebugMode) {
              print("Submitted: $query");
            }
          },
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          hintStyle: const WidgetStatePropertyAll(
            TextStyle(color: Colors.black38),
          ),
          elevation: const WidgetStatePropertyAll(10),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
          ),
          backgroundColor: const WidgetStatePropertyAll(Colors.white),
          hintText: 'Search coffee',
          leading: InkWell(
            onTap: () {
              if (kDebugMode) {
                print(searchController.text);
                context
                    .read<CoffeeItemsCubit>()
                    .fetchCoffeeItemsBySearch(searchController.text);
              }
            },
            child: const Icon(
              Icons.search,
              color: AppColors.brownAppColor,
            ),
          ),
        ),
      ),
    );
  }
}
