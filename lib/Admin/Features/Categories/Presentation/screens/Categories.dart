import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../User/features/home/presentation/cubit/category_cubit/category_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/widgets/custom_loading_progress.dart';
import '../cubits/admin_category_cubit.dart';

class ManageCategoriesScreen extends StatefulWidget {
  const ManageCategoriesScreen({super.key});
  @override
  State<ManageCategoriesScreen> createState() => _ManageCategoriesScreenState();
}

class _ManageCategoriesScreenState extends State<ManageCategoriesScreen> {
  final categoryController = TextEditingController();

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
        backgroundColor: AppColors.brownAppColor,
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text('Manage Categories'),
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          log("Current state in BlocBuilder: $state");
          if (state is CategoryLoading) {
            return const Center(child: CustomLoadingProgress());
          } else if (state is CategoryError) {
            return Center(child: Text(state.errorMessage.toString()));
          } else if (state is CategorySuccess) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.myCategories.length,
              itemBuilder: (context, index) {
                var category = state.myCategories[index];
                return _buildCategoryCard(
                  context,
                  category['name'],
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddEditDialog(context);
        },
        backgroundColor: AppColors.brownAppColor,
        foregroundColor: AppColors.offWhiteAppColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddEditDialog(BuildContext context,
      {bool isEditing = false, String? currentName}) {
    categoryController.text =
        isEditing && currentName != null ? currentName : '';

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.offWhiteAppColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 16,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEditing ? 'Edit Category' : 'Add New Category',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.brownAppColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter category name',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (categoryController.text.isNotEmpty) {
                          if (isEditing) {
                            _editCategory(
                              currentName!,
                              categoryController.text,
                            );
                          } else {
                            _addCategory(categoryController.text);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Category name cannot be empty')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brownAppColor,
                        foregroundColor: AppColors.offWhiteAppColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(isEditing ? 'Update' : 'Add'),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _addCategory(String value) {
    if (value.isNotEmpty) {
      context.read<AdminCategoryCubit>().addCategory(value);
      categoryController.clear();
      Navigator.pop(context);
      context.read<CategoryCubit>().fetchCoffeeCategories();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category name cannot be empty')),
      );
    }
  }

  void _editCategory(String currentName, String newName) async {
    if (newName.isNotEmpty) {
      await context
          .read<AdminCategoryCubit>()
          .updateCategory(currentName, newName);
      categoryController.clear();
      Navigator.pop(context);
      context.read<CategoryCubit>().fetchCoffeeCategories();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category name cannot be empty')),
      );
    }
  }

  void _deleteCategory(String categoryName) async {
    await context.read<AdminCategoryCubit>().deleteCategory(categoryName);
    context.read<CategoryCubit>().fetchCoffeeCategories();
    setState(() {});
  }

  Widget _buildCategoryCard(BuildContext context, String categoryName) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const Icon(Icons.folder, color: AppColors.brownAppColor),
        title: Text(
          categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              _showAddEditDialog(
                context,
                isEditing: true,
                currentName: categoryName,
              );
            } else if (value == 'delete') {
              _deleteCategory(categoryName);
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
