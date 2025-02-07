import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../details/presentation/screen/item_details.dart';
import 'coffe_card_widget.dart';

class CoffeeItemGridView extends StatelessWidget {
  const CoffeeItemGridView({super.key, required this.myItems});
  final List<dynamic> myItems;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.h),
          child: SizedBox(
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: myItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 0.70,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemDetails(coffeeItem: myItems[index]),
                            ));
                      },
                      child: CoffeeCardWidget(cardModel: myItems[index]));
                }),
          ),
        ));
  }
}
