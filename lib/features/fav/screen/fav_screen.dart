import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:coffe_app/features/home/data/models/hive/hive.dart';
import 'package:coffe_app/features/home/presentation/widgets/coffe_card_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    List<CoffeeItem> myItems = MyHive.getCoffeeItemList(MyHive.hiveBox);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   // iconTheme: const IconThemeData(
        //   //   color: Colors.white, //change your color here
        //   // ),
        //   // title: const Text(
        //   //   "Favourites",
        //   //   style: TextStyle(color: AppColors.offWhiteAppColor),
        //   // ),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(
        //         Icons.delete_rounded,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         MyHive.deleteAllFavourites();
        //         log("delete all button pressed");
        //         setState(() {});
        //       },
        //     )
        //   ],
        //   backgroundColor: Colors.transparent,
        //   //  backgroundColor: AppColors.brownAppColor,
        //   elevation: 0,
        // ),
        backgroundColor: AppColors.offWhiteAppColor,
        body: myItems.isEmpty
            ? const Center(
                child: Text("No Favourites",
                    style: TextStyle(color: Colors.black)))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
                child: Column(
                  children: [
                    const Text(
                      'Favorite',
                      style: TextStyle(
                        color: AppColors.brownAppColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: myItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.68,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return CoffeeCardWidget(
                              cardModel: myItems[index],
                            );
                          }),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
