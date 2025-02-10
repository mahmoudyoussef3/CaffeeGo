import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class ItemDetailsScreenForAdmin extends StatelessWidget {
  final dynamic item;
  const ItemDetailsScreenForAdmin({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
        backgroundColor: AppColors.brownAppColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: item.image,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(item.image,
                    height: 200, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              item.description,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
