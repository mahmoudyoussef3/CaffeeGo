import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuildBannerWidget extends StatelessWidget {
  BuildBannerWidget({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        right: 28.0,
        left: 28.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello,\nMahmoud Youssef.',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.2,
                fontFamily: 'Roboto'),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'Ready to start your day with a perfect cup of coffee?',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                height: 1.5,
                fontFamily: 'Roboto',
                color: Colors.white70),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     SizedBox(
          //         width: MediaQuery.of(context).size.width * 3 / 4 - 30,
          //         child: SearchBar(
          //           controller: _searchController,
          //           onChanged: (value) {
          //             _searchController.text = value;
          //             if (kDebugMode) {
          //               print(_searchController.text);
          //             }
          //           },
          //           textStyle: const WidgetStatePropertyAll(TextStyle(
          //             color: Colors.white,
          //             fontSize: 18,
          //             fontWeight: FontWeight.w500,
          //           )),
          //           hintStyle: const WidgetStatePropertyAll(
          //               TextStyle(color: Colors.white30)),
          //           elevation: const WidgetStatePropertyAll(0),
          //           shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(12)))),
          //           backgroundColor:
          //               const WidgetStatePropertyAll(Color(0xff2D2D2D)),
          //           hintText: 'Search coffee',
          //           leading: const Icon(
          //             Icons.search,
          //             color: Colors.white,
          //           ),
          //         )),
          //     //  ),
          //     const SizedBox(
          //       width: 12,
          //     ),
          //     Container(
          //       width: 50,
          //       height: 55,
          //       decoration: const BoxDecoration(
          //         color: AppColors.brownAppColor,
          //         borderRadius: BorderRadius.all(Radius.circular(12)),
          //       ),
          //       child: const Center(
          //         child: Icon(
          //           FontAwesomeIcons.sliders,
          //           size: 16,
          //           color: Colors.white,
          //         ),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
