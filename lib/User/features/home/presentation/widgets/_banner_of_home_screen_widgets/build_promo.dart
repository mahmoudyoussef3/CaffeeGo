import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        SizedBox(
          height: 85.h,
          width: MediaQuery.of(context).size.width,
          child: const BuildBannerWidget(),
        ),
        BuildSearchBar(searchController: _searchController),
      ],
    );
  }
}
