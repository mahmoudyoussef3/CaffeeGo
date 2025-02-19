import 'package:coffe_app/Admin/main_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/admin_items_cubit.dart';
import 'build_item_card.dart';

class DrinksGridView extends StatelessWidget {
  const DrinksGridView({super.key, required this.drinks});

  final List<dynamic> drinks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text(
                      drinks[index].name,
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          style: TextStyle(fontSize: 16, color: Colors.grey),
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
                          final itemName = drinks[index].name;

                          try {
                            final cubit = context.read<AdminItemsCubit>();
                            await cubit.deleteCoffeeItem(itemName, context);

                            if (context.mounted) {
                              Navigator.pop(dialogContext);
                            }

                            showToastMsg('$itemName deleted successfully!');
                          } catch (e) {
                            showToastMsg('Failed to delete item: $e');
                          }
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              child: BuildItemCard(
                title: drinks[index].name,
                description: drinks[index].description,
                imgUrl: drinks[index].image,
              ),
            ), // Your custom item card widget
          );
        });
  }
}
