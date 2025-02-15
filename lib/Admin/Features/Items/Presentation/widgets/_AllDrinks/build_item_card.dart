import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

class BuildItemCard extends StatelessWidget {
  const BuildItemCard(
      {super.key,
      required this.title,
      required this.description,
      required this.imgUrl});
  final String title;
  final String description;
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
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
