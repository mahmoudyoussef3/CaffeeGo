import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';

class BuildCategoryContainer extends StatefulWidget {
  const BuildCategoryContainer(
      {super.key, required this.categories, required this.categoryController});
  final List categories;
  final TextEditingController categoryController;

  @override
  State<BuildCategoryContainer> createState() => _BuildCategoryContainerState();
}

class _BuildCategoryContainerState extends State<BuildCategoryContainer> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 5, bottom: 5),
            child: GestureDetector(
              onTap: () {
                selectedCategory = index;
                widget.categoryController.text =
                    widget.categories[index]['name'];
                setState(() {});
              },
              child: Container(
                width: 100,
                padding:const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectedCategory == index
                        ? AppColors.brownAppColor
                        : Colors.brown.shade100),
                child: Center(
                  child: Text(
                    widget.categories[index]['name'],
                    style: const TextStyle(
                        color: AppColors.offWhiteAppColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
