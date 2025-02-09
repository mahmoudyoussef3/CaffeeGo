import 'package:coffe_app/Admin/Features/Items/Presentation/screens/add_item.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';

class ManageItemsScreen extends StatefulWidget {
  const ManageItemsScreen({super.key});

  @override
  State<ManageItemsScreen> createState() => _ManageItemsScreenState();
}

class _ManageItemsScreenState extends State<ManageItemsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CoffeeItemsCubit>().fetchCoffeeItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: AppColors.offWhiteAppColor,
          centerTitle: true,
          title: const Text('Manage Items'),
          backgroundColor: AppColors.brownAppColor),
      body: BlocBuilder<CoffeeItemsCubit, CoffeeItemsState>(
          builder: (context, state) {
        if (state is CoffeeItemsLoading) {
          return Center(child: CustomLoadingProgress());
        }
        if (state is CoffeeItemsError) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is CoffeeItemsSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.items.length, // Replace with your dynamic data
            itemBuilder: (context, index) {
              return _buildItemCard(
                context,
                '${state.items[index].name}',
                '${state.items[index].description}',
                '${state.items[index].image}',
              );
            },
          );
        }
        return SizedBox.shrink();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppStrings.addItems);
        },
        backgroundColor: AppColors.brownAppColor,
        foregroundColor: AppColors.offWhiteAppColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemCard(
      BuildContext context, String title, String description, String imgUrl) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(imgUrl),
        ),
        title: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(),
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              Navigator.pushNamed(context, '/editItem');
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
