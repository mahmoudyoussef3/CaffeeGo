import 'package:coffe_app/admin/main_admin.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/details/presentation/screen/item_details.dart';
import 'package:coffe_app/features/fav/Data/hive_manager.dart';
import 'package:coffe_app/features/fav/Presentation/widgets/empty_fav_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../home/data/models/coffe_item.dart';
import '../widgets/coffee_card_widget_in_fav_screen.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<CoffeeItem> myFavItems = [];
  getAllFavItems() async {
    List<CoffeeItem> myItems = await CoffeeHiveService().getAllItems();
    setState(() {
      myFavItems = myItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllFavItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.brownAppColor,
          foregroundColor: AppColors.offWhiteAppColor,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.delete_rounded,
              ),
              onPressed: myFavItems.isEmpty
                  ? () {}
                  : () async {
                      await CoffeeHiveService().deleteAllItems().then(
                        (value) {
                          showToastMsg('All Items deleted successfully!');
                        },
                      );
                      myFavItems.clear();
                      setState(() {});
                    },
            )
          ],
          title: Text(
            'Favourites',
            style: TextStyle(
              fontFamily: 'Lato',
              color: AppColors.offWhiteAppColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
              letterSpacing: 1.5,
            ),
          )),
      backgroundColor: AppColors.offWhiteAppColor,
      body: myFavItems.isEmpty
          ? EmptyFavList()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                        coffeeItem: myFavItems[index]),
                                  ));
                            },
                            child: CoffeeCardWidgetInFavScreen(
                              coffeeItem: myFavItems[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: AppColors.brownAppColor,
                            endIndent: 30,
                            indent: 30,
                          );
                        },
                        itemCount: myFavItems.length),
                  ),
                ],
              ),
            ),
    );
  }
}
