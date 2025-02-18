import 'package:coffe_app/admin/main_admin.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/details/presentation/screen/item_details.dart';
import 'package:coffe_app/features/fav/Data/hive_manager.dart';
import 'package:coffe_app/features/fav/Presentation/widgets/empty_fav_list.dart';
import 'package:coffe_app/features/home/presentation/widgets/_banner_of_home_screen_widgets/build_top_container.dart';
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
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //     backgroundColor: AppColors.brownAppColor,
        //     foregroundColor: AppColors.offWhiteAppColor,
        //     centerTitle: true,
        //     actions: <Widget>[
        //       IconButton(
        //         icon: const Icon(
        //           Icons.delete_rounded,
        //         ),
        //         onPressed: myFavItems.isEmpty
        //             ? () {}
        //             : () async {
        //                 await CoffeeHiveService().deleteAllItems().then(
        //                   (value) {
        //                     showToastMsg('All Items deleted successfully!');
        //                   },
        //                 );
        //                 myFavItems.clear();
        //                 setState(() {});
        //               },
        //       )
        //     ],
        //     title: Text(
        //       'Favourites',
        //       style: TextStyle(
        //         fontFamily: 'Lato',
        //         color: AppColors.offWhiteAppColor,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 28,
        //         letterSpacing: 1.5,
        //       ),
        //     )),
        body: myFavItems.isEmpty
            ? EmptyFavList()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: AppColorsDarkTheme.greyAppColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Image.asset('assets/icons/drawer_icon.png'),
                            ),
                          ),
                        ),
                        Text(
                          'Favorites',
                          style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColorsDarkTheme.whiteAppColor),
                        ),
                        InkWell(
                          onTap: myFavItems.isEmpty
                              ? () {}
                              : () async {
                                  await CoffeeHiveService()
                                      .deleteAllItems()
                                      .then(
                                    (value) {
                                      showToastMsg(
                                          'All Items deleted successfully!');
                                    },
                                  );
                                  myFavItems.clear();
                                  setState(() {});
                                },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: AppColorsDarkTheme.darkBlueAppColor),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                  color: AppColorsDarkTheme.redAppColor,
                                  size: 24,
                                  Icons.delete_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
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
      ),
    );
  }
}
