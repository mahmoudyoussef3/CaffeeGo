
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/coffe_card_model.dart';
import '../widgets/coffe_card_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEDEDED),
        body:Column(
          children: [
            Container(height: 400,color: Colors.brown,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                height: 400,
                color: Colors.white,
                child:
                GridView.builder(
                    itemCount: listCardModel.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return CoffeCardWidget(cardModel: listCardModel[index]);
                    }
                ),),
            )
          ],
        )


    );
  }

  final List<CoffeCardModel>   listCardModel  = [
    CoffeCardModel(name: "Caffe Mocha", image: "assets/images/caffe_mocha.png", description: "Deep Foam", price: 34.5, rate: 8.5),
    CoffeCardModel(name: "Flat White", image: "assets/images/flat_white.png", description: "Espresso", price: 44.5, rate: 6.5),
    CoffeCardModel(name: "Mocha Fusi", image: "assets/images/mocha_fusi.png", description: "Ice/Hot", price: 37.5, rate: 9.0),
    CoffeCardModel(name: "Caffe Panna", image: "assets/images/caffe_panna.png", description: "Ice/Hot", price: 34.5, rate: 8.5),
  ];
}
