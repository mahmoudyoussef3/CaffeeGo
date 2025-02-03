import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/widgets/custom_loading_progress.dart';
import '../../../../../features/home/presentation/cubit/category_cubit/category_cubit.dart';

class ManageCategoriesScreen extends StatefulWidget {
  const ManageCategoriesScreen({super.key});

  @override
  State<ManageCategoriesScreen> createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().fetchCoffeeCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.offWhiteAppColor,
        centerTitle: true,
        title: const Text('Manage Categories'),
        backgroundColor: AppColors.brownAppColor,
      ),
      body:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        log("Current state in BlocBuilder: $state");
        if (state is CategoryLoading) {
          return Center(child: CustomLoadingProgress());
        } else if (state is CategoryError) {
          return Text(state.errorMessage.toString());
        } else if (state is CategorySuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.myCategories.length,
            itemBuilder: (context, index) {
              return _buildCategoryCard(
                  context, "${state.myCategories[index]['name']}");
            },
          );
        }
        return SizedBox.shrink();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.brownAppColor,
        foregroundColor: AppColors.offWhiteAppColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const Icon(Icons.folder, color: AppColors.brownAppColor),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.pushNamed(context, '/editCategory');
            } else if (value == 'delete') {
              // Handle delete logic here
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
        ),
      ),
    );
  }
}
