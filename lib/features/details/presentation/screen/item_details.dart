import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/features/cart/Presentation/cubit/user_data_cubit.dart';
import 'package:coffe_app/features/home/data/models/hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/data/models/coffe_item.dart';
import '../widgets/add_to_cart_button.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool isExpanded = false;
  int coffeeSize = 1;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });
    context.read<UserDataCubit>().fetchUserCart();
  }

  @override
  Widget build(BuildContext context) {
    CoffeeItem? coffeeItem =
        ModalRoute.of(context)?.settings.arguments as CoffeeItem?;
    if (coffeeItem == null) {
      return const Scaffold(
          body: Center(
        child: Center(
          child: Text("Error"),
        ),
      ));
    }
    List<String> coffeeSizeList = [
      "small",
      "medium",
      "large",
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Detail',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
              ),
              onPressed: () {
                log("favourite button pressed");
                MyHive.saveSingleHiveItem(coffeeItem, MyHive.hiveBox);
                MyHive.getCoffeeItemList(MyHive.hiveBox);
              },
            ),
          ],
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: AnimatedOpacity(
                    duration: const Duration(seconds: 1),
                    opacity: _opacity,
                    child: CachedNetworkImage(
                      imageUrl: coffeeItem.image,
                      height: 240,
                      width: MediaQuery.of(context).size.width - 20,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    child: Text(
                      maxLines: 1,
                      coffeeItem.name,
                      style: const TextStyle(
                        letterSpacing: 2,
                        fontSize: 24,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 22,
                    ),
                    Text(
                      ' ${coffeeItem.rate}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              buildTag(coffeeItem),
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
                ),
              ),
              const SizedBox(height: 8),
              Text(
                coffeeItem.description,
                maxLines: isExpanded ? null : 1,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(
                  isExpanded ? 'Read Less' : 'Read More',
                  style: const TextStyle(
                    color: AppColors.brownAppColor,
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
              const Text(
                'Size',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      3,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                coffeeSize = index;
                                coffeeItem.selectedSize =
                                    coffeeSizeList[coffeeSize];
                                coffeeItem.uniqueId =
                                    coffeeItem.id + coffeeItem.selectedSize;
                              });
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              elevation: 0,
                              color: coffeeSize == index
                                  ? AppColors.brownAppColor
                                  : Colors.white,
                              child: Container(
                                height: 37,
                                width: 85,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: coffeeSize == index
                                        ? AppColors.offWhiteAppColor
                                        : Colors.black26,
                                  ),
                                  color: coffeeSize == index
                                      ? AppColors.brownAppColor
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                    child: Text(
                                  coffeeSizeList[index],
                                  style: TextStyle(
                                      color: coffeeSize == index
                                          ? Colors.white
                                          : Colors.black),
                                )),
                              ),
                            ),
                          ))),
              const Spacer(
                flex: 2,
              ),
              Center(
                  child: AddToCartButton(
                price: coffeeItem.sizes[coffeeSizeList[coffeeSize]].toString(),
                coffeeItem: coffeeItem,
              )),
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
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.local_drink,
                        size: 16,
                        color: AppColors.brownAppColor,
                      ),
                      const SizedBox(width: 4),
                      Text(e.name),
                    ],
                  ),
                );
              },
            ).toList()),
      ]),
    );
  }
}
// Stack(
//   children: [
//     Positioned(
//       height: MediaQuery.of(context).size.height / 2.5,
//       right: 0,
//       left: 0,
//       child: Image.network(
//         coffeeItem.image,
//         fit: BoxFit.cover,
//       ),
//     ),
//     Positioned(
//       left: 0,
//       right: 0,
//       top: MediaQuery.of(context).size.height / 3.6,
//       child: Container(
//         height: 80,
//         decoration: const BoxDecoration(color: Colors.black26),
//         child: Padding(
//           padding:
//               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 3 / 4,
//                     child: Text(
//                       maxLines: 1,
//                       coffeeItem.name,
//                       style: const TextStyle(
//                         letterSpacing: 2,
//                         fontSize: 24,
//                         overflow: TextOverflow.fade,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const Text(
//                     ' Indonesia, Jakarta',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.white70,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(6.0),
//                   child: Row(
//                     children: [
//                       const Icon(
//                         Icons.star,
//                         color: Colors.white,
//                         size: 16,
//                       ),
//                       Text(
//                         ' ${coffeeItem.rate}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//     Positioned(
//       top: MediaQuery.of(context).size.height / 2.8,
//       left: 0,
//       right: 0,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(32),
//             topRight: Radius.circular(32),
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             const SizedBox(
//               height: 16,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 buildTag(Icons.coffee, 'Coffee'),
//                 const SizedBox(width: 8),
//                 buildTag(Icons.food_bank, 'Chocolate'),
//                 const SizedBox(width: 8),
//                 buildTag(Icons.local_fire_department, 'Medium Roasted'),
//               ],
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'About',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               coffeeItem.description,
//               maxLines: isExpanded ? null : 1,
//               overflow: isExpanded
//                   ? TextOverflow.visible
//                   : TextOverflow.ellipsis,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   isExpanded = !isExpanded;
//                 });
//               },
//               child: Text(
//                 isExpanded ? 'Read Less' : 'Read More',
//                 style: const TextStyle(
//                   color: AppColors.brownAppColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             const Text(
//               'Coffee Size',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const CoffeeSizeItems(),
//             const SizedBox(height: 150),
//             const Center(child: AddToCartButton()),
//           ],
//         ),
//       ),
//     ),
//   ],
// ),
