import 'package:coffe_app/core/utils/components/app_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../main_admin.dart';
import '../../cubits/admin_items_cubit.dart';

class BuildAddDrinkCubit extends StatelessWidget {
  const BuildAddDrinkCubit({super.key, required this.addDrink});
  final Function() addDrink;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminItemsCubit, AdminItemsState>(
      builder: (context, state) {
        if (state is AdminItemsLoading) {
          return  AppComponents.customLoadingProgress();
        } else if (state is AdminItemsError) {
          return Text(state.errorMessage.toString());
        } else if (state is AdminItemsLoaded) {
        AppComponents.showToastMsg('New item added successfully!');
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, AppStrings.manageItems);
          });
        }

        return ElevatedButton(
          onPressed: () async {
            await addDrink();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.brownAppColor,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Center(
            child: Text("Add New Drink",
                style: TextStyle(
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white)),
          ),
        );
      },
    );
  }
}
