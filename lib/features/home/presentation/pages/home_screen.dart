import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/home/presentation/widgets/build_banner_widget.dart';
import 'package:coffe_app/features/home/presentation/widgets/build_promo.dart';
import 'package:coffe_app/features/home/presentation/widgets/categories_toggle.dart';
import 'package:flutter/material.dart';
import '../../data/models/coffe_card_model.dart';
import '../widgets/coffe_card_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            BuildPromo(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: CategoriesToggle(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 400,
                color: Colors.white,
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listCardModel.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AppStrings.itemDetails),
                          child:
                              CoffeCardWidget(cardModel: listCardModel[index]));
                    }),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  final List<CoffeCardModel> listCardModel = [
    CoffeCardModel(
        name: "Caffe Mocha",
        image: "assets/images/caffe_mocha.png",
        description: "Deep Foam",
        price: 34.5,
        rate: 8.5),
    CoffeCardModel(
        name: "Flat White",
        image: "assets/images/flat_white.png",
        description: "Espresso",
        price: 44.5,
        rate: 6.5),
    CoffeCardModel(
        name: "Mocha Fusi",
        image: "assets/images/mocha_fusi.png",
        description: "Ice/Hot",
        price: 37.5,
        rate: 9.0),
    CoffeCardModel(
        name: "Caffe Panna",
        image: "assets/images/caffe_panna.png",
        description: "Ice/Hot",
        price: 34.5,
        rate: 8.5),
  ];
}
