import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class BuildContainerItemInDrawer extends StatelessWidget {
  const BuildContainerItemInDrawer(
      {super.key,
      required this.onTapFunction,
      required this.icon,
      required this.label});
  final void Function() onTapFunction;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.brownAppColor,
            borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: Icon(
            icon,
            color: AppColors.offWhiteAppColor,
          ),
          title: Text(
            label,
            style: TextStyle(color: AppColors.offWhiteAppColor),
          ),
        ),
      ),
    );
  }
}
