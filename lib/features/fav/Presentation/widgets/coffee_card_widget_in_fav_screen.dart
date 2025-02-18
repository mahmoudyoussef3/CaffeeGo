import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../home/data/models/coffe_item.dart';

class CoffeeCardWidgetInFavScreen extends StatelessWidget {
  const CoffeeCardWidgetInFavScreen({super.key, required this.coffeeItem});

  final CoffeeItem coffeeItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: CachedNetworkImage(
              imageUrl: coffeeItem.image,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColorsDarkTheme.darkBlueAppColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                            color: AppColorsDarkTheme.redAppColor,
                            size: 18,
                            Icons.favorite),
                      ),
                    ),
                    onTap: () {}),
              ],
            ),
          ))
        ]),
        // Details Section
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(colors: [
                AppColorsDarkTheme.greyAppColor,
                AppColorsDarkTheme.darkBlueAppColor,
              ], end: Alignment.bottomRight, begin: Alignment.topLeft),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        coffeeItem.name,
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: '\$ ',
                          style: const TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                              color: AppColors.brownAppColor),
                        ),
                        TextSpan(
                            text: '${coffeeItem.sizes['medium']}',
                            style: const TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                                color: AppColorsDarkTheme.whiteAppColor))
                      ]),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  coffeeItem.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColorsDarkTheme.greyLighterAppColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                // Rating and Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star,
                            color: AppColorsDarkTheme.brownAppColor, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          coffeeItem.rate,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColorsDarkTheme.whiteAppColor,
                          ),
                        ),
                      ],
                    ),
                    // Add to Cart Button
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
