import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/home/presentation/widgets/build_promo.dart';
import 'package:coffe_app/features/home/presentation/widgets/categories_toggle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../data/models/coffe_card_model.dart';
import '../../data/models/coffe_item.dart';
import '../widgets/coffe_card_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder(
              future: fetchCoffeeItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  ); //waiting state
                }
                if (snapshot.hasData) {
                  List<CoffeeItem> listOfDrinks = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        BuildPromo(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 12),
                          child: CategoriesToggle(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Container(
                            height: 400,
                            color: Colors.white,
                            child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: listOfDrinks.length,
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
                                          context, AppStrings.itemDetails,arguments: listOfDrinks[index]),
                                      child: CoffeCardWidget(
                                          cardModel: listOfDrinks[index]));
                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Error"),
                  );
                }
              }, // a previously-obtained Future<String> or null
            )));
  }




    Future<List<CoffeeItem>> fetchCoffeeItems() async {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;

      try {
        // Reference to the coffee_items collection
        QuerySnapshot snapshot =
            await _firestore.collection('coffee_items').get();

        // Map the documents to CoffeeItem models
        List<CoffeeItem> coffeeItems = snapshot.docs.map((doc) {
          return CoffeeItem.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
        log('Fetched ${coffeeItems.length} coffee items done');
        log('Fetched ${coffeeItems[0].sizes["medium"]} coffee sizes done');
        return coffeeItems;
      } catch (e) {
        print('Error fetching coffee items: $e');
        return [];
      }

  }
}
