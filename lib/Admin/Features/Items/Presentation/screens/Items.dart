import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
        title: const Text(
          'Manage Items',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.brownAppColor,
        elevation: 0,
      ),
      body: BlocBuilder<CoffeeItemsCubit, CoffeeItemsState>(
        builder: (context, state) {
          if (state is CoffeeItemsLoading) {
            return CustomLoadingProgress();
          }
          if (state is CoffeeItemsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage, style: TextStyle(color: Colors.red)),
                ],
              ),
            );
          }
          if (state is CoffeeItemsSuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return _buildItemCard(
                  context,
                  state.items[index].name,
                  state.items[index].description,
                  state.items[index].image,
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
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
      color: AppColors.offWhiteAppColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Hero(
            tag: imgUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: 120,
                width: 120,
                imageUrl: imgUrl,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeInDuration: const Duration(milliseconds: 1000),
                fadeOutDuration: const Duration(milliseconds: 1000),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }
}
