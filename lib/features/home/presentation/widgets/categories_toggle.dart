import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoriesToggle extends StatefulWidget {
  const CategoriesToggle({super.key});

  @override
  State<CategoriesToggle> createState() => _CategoriesToggleState();
}

class _CategoriesToggleState extends State<CategoriesToggle> {
  int selectedIndex = 0;

  final List<String> categories = [
    'All Coffee',
    'Macchiato',
    'Latte',
    'Americano'
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.brownAppColor
                    : AppColors.greyAppColor,
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(
                //     color: isSelected ? Colors.white : Colors.black)
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16),
              ),
            ),
          );
        }),
      ),
    );
  }
}
