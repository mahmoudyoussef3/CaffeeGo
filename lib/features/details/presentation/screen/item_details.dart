import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/Admin/main_admin.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/home/presentation/widgets/_banner_of_home_screen_widgets/build_top_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../fav/Data/hive_manager.dart';
import '../../../home/data/models/coffe_item.dart';
import '../widgets/add_to_cart_button.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.coffeeItem});
  final CoffeeItem coffeeItem;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool isExpanded = false;
  int? coffeeSize;
  double _opacity = 0.0;
  List<String> coffeeSizeList = [
    "small",
    "medium",
    "large",
  ];

  bool isFavorite = false;
  getAllFavItems() async {
    bool exists = await CoffeeHiveService().isItemAdded(widget.coffeeItem.id);

    setState(() {
      isFavorite = exists;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    context.read<UserDataCubit>().fetchUserCart();
    getAllFavItems();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,)
,              Stack(children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: _opacity,
                      child: CachedNetworkImage(
                        imageUrl: widget.coffeeItem.image,
                        height: 240,
                        width: MediaQuery.of(context).size.width - 20,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
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
                              color: isFavorite
                                  ? AppColorsDarkTheme.redAppColor
                                  : AppColorsDarkTheme.greyLighterAppColor,
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                          ),
                        ),
                        onTap: () async {
                          if (isFavorite) {
                            setState(() {
                              isFavorite = false;
                            });
                            await CoffeeHiveService()
                                .deleteItem(widget.coffeeItem.id);
                          } else {
                            setState(() {
                              isFavorite = true;
                            });
                            await CoffeeHiveService()
                                .addItem(widget.coffeeItem)
                                .then(
                              (value) {
                                showToastMsg('Item added Successfully!');
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ))
              ]),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    child: Text(
                      maxLines: 1,
                      widget.coffeeItem.name,
                      style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 22.sp,
                        overflow: TextOverflow.ellipsis,
                        color: AppColorsDarkTheme.whiteAppColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ).animate().slideY(duration: 500.ms, begin: 0.5),
                  ),
                  const Spacer(),
                  Row(children: [
                    const Icon(
                      Icons.star,
                      color: AppColorsDarkTheme.brownAppColor,
                      size: 22,
                    ),
                    Text(
                      ' ${widget.coffeeItem.rate}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColorsDarkTheme.whiteAppColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ]).animate().fade(
                        duration: 500.ms,
                      ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              buildTag(widget.coffeeItem)
                  .animate()
                  .slideY(duration: 500.ms, begin: 0.8),
              const SizedBox(height: 5),
              const Divider(
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(height: 16),
              const Text(
                'Description',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColorsDarkTheme.greyLighterAppColor),
              ).animate().fade(
                    duration: 500.ms,
                  ),
              const SizedBox(height: 8),
              Text(
                widget.coffeeItem.description,
                maxLines: isExpanded ? null : 2,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: const TextStyle(
                    color: AppColorsDarkTheme.greyLighterAppColor,
                    fontSize: 14,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500),
              ).animate().fade(duration: 400.ms),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'Read Less' : 'Read More',
                  style: const TextStyle(
                    color: AppColorsDarkTheme.brownAppColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Size',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColorsDarkTheme.greyLighterAppColor),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      3,
                      (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              coffeeSize = index;
                              widget.coffeeItem.selectedSize =
                                  coffeeSizeList[coffeeSize ?? 0];
                              widget.coffeeItem.uniqueId =
                                  widget.coffeeItem.id +
                                      widget.coffeeItem.selectedSize;
                            });
                          },
                          child: Container(
                            height: 45,
                            width: 95,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: coffeeSize == index
                                    ? AppColorsDarkTheme.brownAppColor
                                    : AppColorsDarkTheme.darkBlueAppColor,
                              ),
                              color: AppColorsDarkTheme.greyAppColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                                child: Text(
                              coffeeSizeList[index],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: coffeeSize == index
                                      ? AppColorsDarkTheme.brownAppColor
                                      : AppColorsDarkTheme.greyLighterAppColor),
                            )),
                          ).animate().scale()))),
              const Spacer(
                flex: 2,
              ),
              Center(
                  child: AddToCartButton(
                price: widget.coffeeItem.sizes[coffeeSizeList[coffeeSize ?? 0]]
                    .toString(),
                coffeeItem: widget.coffeeItem,
              ).animate().scale()),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTag(CoffeeItem coffeeItem) {
    return SizedBox(
      height: 50,
      child: ListView(scrollDirection: Axis.horizontal, children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: coffeeItem.ingredients.map(
              (e) {
                return Container(
                  height: 35,
                  margin: const EdgeInsets.only(right: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColorsDarkTheme.greyAppColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.local_drink,
                        size: 16,
                        color: AppColorsDarkTheme.brownAppColor,
                      ),
                      const SizedBox(width: 4),
                      Text(e.name),
                    ],
                  ),
                ).animate().fade(duration: 400.ms);
              },
            ).toList()),
      ]),
    );
  }
}
