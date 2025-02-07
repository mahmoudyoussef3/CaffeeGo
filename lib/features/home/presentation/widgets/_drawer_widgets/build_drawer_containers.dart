import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import 'build_container_item_in_drawer.dart';
import 'build_logout_dialoug.dart';

class BuildDrawerContainers extends StatelessWidget {
  const BuildDrawerContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildContainerItemInDrawer(
          onTapFunction: () => Navigator.pushNamed(context, AppStrings.cart),
          label: 'Cart',
          icon: Icons.shopping_cart,
        ),
        BuildContainerItemInDrawer(
          label: 'Favourites',
          icon: Icons.favorite,
          onTapFunction: () => Navigator.pushNamed(context, AppStrings.fav),
        ),
        BuildContainerItemInDrawer(
          icon: Icons.coffee,
          label: 'Orders',
          onTapFunction: () =>
              Navigator.pushNamed(context, AppStrings.orderHistory),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 1 / 3 - 10.h,
        ),
        const Divider(color: AppColors.greyAppColor),
        BuildContainerItemInDrawer(
            label: 'Logout',
            icon: Icons.logout,
            onTapFunction: () {
              Navigator.pop(context);
              buildTheDialogOfLogout(context);
            }),
        const SizedBox(
          height: 0,
        )
      ],
    );
  }

  void buildTheDialogOfLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BuildLogoutDialog();
      },
    );
  }
}
