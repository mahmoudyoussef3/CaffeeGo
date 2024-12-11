import 'package:flutter/material.dart';

import 'build_banner_widget.dart';

class BuildPromo extends StatelessWidget {
  const BuildPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(
        children: [
          Column(
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff000000), Color(0xff2D2D2D)],
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomLeft)),
                child: BuildBannerWidget(),
              ),
              Container(
                height: 70,
                color: Colors.transparent,
              )
            ],
          ),
          Positioned(
              left: 30,
              top: 220,
              child: Image.asset('assets/images/Banner.png'))
        ],
      )
    ]);
  }
}
