import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/Admin/Features/Items/Presentation/cubits/admin_items_cubit.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          title: Text(
                            state.items[index].name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                            'Are you sure you want to delete this item?',
                            style: TextStyle(fontSize: 16),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),
                              child: const Text(
                                'Cancel',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                final itemName = state.items[index].name;
                                try {
                                  final cubit = context.read<AdminItemsCubit>();
                                  await cubit.deleteCoffeeItem(itemName);

                                  if (context.mounted) {
                                    Navigator.pop(dialogContext);
                                  }
                                  setState(() {
                                    context
                                        .read<CoffeeItemsCubit>()
                                        .fetchCoffeeItems();
                                  });

                                  Fluttertoast.showToast(
                                    msg: "$itemName deleted successfully!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                } catch (e) {
                                  Fluttertoast.showToast(
                                    msg: "Failed to delete item: $e",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      splashColor: Colors.grey.withOpacity(0.2),
                      child: _buildItemCard(
                        context,
                        state.items[index].name,
                        state.items[index].description,
                        state.items[index].image,
                      ),
                    ),
                  ),
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
