import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_colors.dart';
import 'build_banner_widget.dart';

class BuildPromo extends StatelessWidget {
  BuildPromo({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Column(
            children: [
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff000000), Color(0xff2D2D2D)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomLeft)),
                child: BuildBannerWidget(),
              ),
              Container(
                height: 40,
                color: Colors.transparent,
              )
            ],
          ),
          Positioned(
            left: 50,
            top: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    width: MediaQuery.of(context).size.width * 3 / 4 - 50,
                    child: SearchBar(
                      controller: _searchController,
                      onChanged: (value) {
                        _searchController.text = value;
                        if (kDebugMode) {
                          print(_searchController.text);
                        }
                      },
                      textStyle: const WidgetStatePropertyAll(TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                      hintStyle: const WidgetStatePropertyAll(
                          TextStyle(color: Colors.black38)),
                      elevation: const WidgetStatePropertyAll(10),
                      shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                      backgroundColor:
                          const WidgetStatePropertyAll(Colors.white),
                      hintText: 'Search coffee',
                      leading: const Icon(
                        Icons.search,
                        color: AppColors.brownAppColor,
                      ),
                    )),
                //  ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  width: 50,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: AppColors.brownAppColor,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Center(
                    child: Icon(
                      FontAwesomeIcons.sliders,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
          // child: Image.asset('assets/images/Banner.png'))
        ],
      )
    ]);
  }
}
