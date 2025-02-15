import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/widgets/custom_loading_progress.dart';
import '../../../../../../features/home/presentation/cubit/category_cubit/category_cubit.dart';
import 'build_category_container.dart';

class BuildCategoryBlocContainer extends StatelessWidget {
  const BuildCategoryBlocContainer({super.key, required this.categoryController});
  final TextEditingController categoryController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        log("Current state in BlocBuilder: $state");
        if (state is CategoryLoading) {
          return CustomLoadingProgress();
        } else if (state is CategoryError) {
          return Text(state.errorMessage.toString());
        } else if (state is CategorySuccess) {
          var myCategories = List<Map<String, dynamic>>.from(state.myCategories)
            ..removeAt(0);
          return BuildCategoryContainer(
            categories: myCategories,
            categoryController: categoryController,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
