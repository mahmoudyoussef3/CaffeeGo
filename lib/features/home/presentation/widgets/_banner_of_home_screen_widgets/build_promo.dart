import 'dart:async';
import 'package:coffe_app/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import 'build_banner_widget.dart';
import 'build_search_bar.dart';

class BuildPromo extends StatefulWidget {
  const BuildPromo({super.key});

  @override
  State<BuildPromo> createState() => _BuildPromoState();
}

class _BuildPromoState extends State<BuildPromo> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

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
                  height: 125.h,
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
                SizedBox(height: 35.h),
              ],
            ),
            Positioned(
              left: 45.w,
              top: 100.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildSearchBar(searchController: _searchController),
                  SizedBox(width: 8.w),
                  Container(
                    width: 45.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: AppColors.brownAppColor,
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.sliders,
                        size: 16.r,
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
