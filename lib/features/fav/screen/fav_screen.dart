import 'dart:developer';

import 'package:coffe_app/features/fav/widgets/coffee_card_widget_in_fav_screen.dart';
import 'package:coffe_app/features/fav/widgets/empty_fav_list.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:coffe_app/features/home/data/models/hive/hive.dart';
import 'package:coffe_app/features/home/presentation/widgets/coffe_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        appBar: AppBar(
          title: Text('Favourite'),
          foregroundColor: AppColors.brownAppColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.delete_rounded,
              ),
              onPressed: () {
                MyHive.deleteAllFavourites();
                log("delete all button pressed");
                myItems.clear();
                setState(() {});
              },
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: AppColors.offWhiteAppColor,
        body: myItems.isEmpty
            ? EmptyFavList()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return CoffeeCardWidgetInFavScreen(
                              coffeeItem: myItems[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: AppColors.brownAppColor,
                              endIndent: 30,
                              indent: 30,
                            );
                          },
                          itemCount: myItems.length),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
