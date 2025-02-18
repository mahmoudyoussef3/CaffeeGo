import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../cubit/coffe_items/coffee_items_cubit.dart';

class CategoriesContainer extends StatefulWidget {
  CategoriesContainer(
      {super.key, required this.myCategories, required this.selectedIndex});
  final List<dynamic> myCategories;
  int selectedIndex;

  @override
  State<CategoriesContainer> createState() => _CategoriesContainerState();
}

class _CategoriesContainerState extends State<CategoriesContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.myCategories.length, (index) {
        final isSelected = widget.selectedIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.selectedIndex = index;
              context.read<CoffeeItemsCubit>().category =
                  widget.myCategories[index]['name'];
              context.read<CoffeeItemsCubit>().fetchCoffeeItems();
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColorsDarkTheme.brownAppColor
                  : AppColorsDarkTheme.greyAppColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              widget.myCategories[index]['name'],
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : AppColorsDarkTheme.greyLessDegreeAppColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }),
    );
  }
}
