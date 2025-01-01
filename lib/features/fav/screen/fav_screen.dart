
import 'dart:developer';

import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:coffe_app/features/home/data/models/hive/hive.dart';
import 'package:coffe_app/features/home/presentation/widgets/coffe_card_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../home/data/models/hive/hive_item.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {

    List<CoffeeItem> myItems = MyHive.getCoffeeItemList(MyHive.hiveBox);
    return Scaffold(

        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: const Text(
            "Favourites",
            style: TextStyle(color: AppColors.offWhiteAppColor),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                MyHive.deleteAllFavourites();
                log("delete all button pressed");
                setState(() {

                });
              },
            )
          ],
          backgroundColor: AppColors.brownAppColor,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body:myItems.isEmpty? const Center(child: Text("No Favourites",style: TextStyle(color: Colors.black))):   GridView.builder(
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
                      return CoffeCardWidget(cardModel:myItems[index] ,);

                    }),
    );

  }
}
