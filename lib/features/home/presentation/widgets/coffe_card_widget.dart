import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/models/coffe_card_model.dart';

class CoffeCardWidget extends StatelessWidget {
  const CoffeCardWidget({super.key, required this.cardModel});
 final CoffeCardModel cardModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          color: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              child: Column(children: [

                Container(
                  height: 238,
                  child: Column(
                    children: [
                      Container(
                          height: 128,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.asset(cardModel.image) .image,
                            fit: BoxFit.cover,
                          ),),
                        child:  Padding(
                          padding: const EdgeInsets.only(top: 8,right: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/rate_icon.svg',
                                  height: 16.6,
                                  width: 16.6,
                                  allowDrawingOutsideViewBox: true,
                                ),
                                Text(" ${cardModel.rate}",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),),


                          ]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacer(flex: 1,),
                              Text(cardModel.name,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                              Spacer(flex: 2,),
                              Text(cardModel.description,style: TextStyle(color: Color(0xffA2A2A2),fontSize: 16,fontWeight: FontWeight.w600),),
                              Spacer(flex: 3,),
                              Row(children: [
                                Text("\$ ${cardModel.price}",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
                                Spacer(),

                                 CustomAddButton(onTap: () {
                                    print("dont press me again");
                                  },),

                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAddButton extends StatelessWidget {
    CustomAddButton({
    super.key,required this.onTap
  });

  void Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
          height: 32,
          width: 32,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffC67C4E),
          ),

          child: const Center(child: Icon(Icons.add,color: Colors.white,size: 24,))),
    );
  }
}
