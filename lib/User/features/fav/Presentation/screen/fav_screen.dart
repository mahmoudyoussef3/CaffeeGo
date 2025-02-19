import 'package:coffe_app/admin/main_admin.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../details/presentation/screen/item_details.dart';
import '../../../home/data/models/coffe_item.dart';
import '../../Data/hive_manager.dart';
import '../widgets/coffee_card_widget_in_fav_screen.dart';
import '../widgets/empty_fav_list.dart';

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
        body: myFavItems.isEmpty
            ? const EmptyFavList()
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
                        const Text(
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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                  color: AppColorsDarkTheme.redAppColor,
                                  size: 24,
                                  Icons.delete_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: ListView.builder(
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
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CoffeeCardWidgetInFavScreen(
                                  coffeeItem: myFavItems[index],
                                ),
                              ),
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
