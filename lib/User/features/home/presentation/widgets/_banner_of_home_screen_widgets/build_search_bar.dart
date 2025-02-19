import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_colors.dart';
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
      width: MediaQuery.of(context).size.width - 30,
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
              color: AppColorsDarkTheme.greyLighterAppColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          hintStyle: WidgetStatePropertyAll(
            TextStyle(
                color: AppColorsDarkTheme.greyLessDegreeAppColor,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp),
          ),
          elevation: const WidgetStatePropertyAll(10),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r)),
            ),
          ),
          backgroundColor:
              const WidgetStatePropertyAll(AppColorsDarkTheme.greyAppColor),
          hintText: 'Find Your Coffee...',
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
              color: AppColorsDarkTheme.greyLessDegreeAppColor,
            ),
          ),
        ),
      ),
    );
  }
}
