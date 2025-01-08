import 'dart:async';
import 'package:coffe_app/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_colors.dart';
import 'build_banner_widget.dart';

class BuildPromo extends StatefulWidget {
  const BuildPromo({super.key});

  @override
  State<BuildPromo> createState() => _BuildPromoState();
}

class _BuildPromoState extends State<BuildPromo> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    //_searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: BuildBannerWidget(),
                ),
                const SizedBox(height: 40), // For spacing below the banner
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
                       //  /// TODO: Add search functionality
                        context.read<CoffeeItemsCubit>().fetchCoffeeItemsBySearch(_searchController.text);

                        if (kDebugMode) {
                          print("Typing: $value");
                        }
                      },
                      onSubmitted: (query) {
                        // _performSearch(query);
                        if (kDebugMode) {
                          print("Submitted: $query");

                        }
                      },
                      textStyle: const WidgetStatePropertyAll(
                        TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      hintStyle: const WidgetStatePropertyAll(
                        TextStyle(color: Colors.black38),
                      ),
                      elevation: const WidgetStatePropertyAll(10),
                      shape: const WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      backgroundColor:
                      const WidgetStatePropertyAll(Colors.white),
                      hintText: 'Search coffee',
                      leading: InkWell(
                        onTap: () {
                          if (kDebugMode) {
                            print("${_searchController.text}");
                            context.read<CoffeeItemsCubit>().fetchCoffeeItemsBySearch(_searchController.text);


                          }},
                        child: const Icon(
                          Icons.search,
                          color: AppColors.brownAppColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
