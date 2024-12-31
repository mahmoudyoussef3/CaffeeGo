import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CoffeCardWidget extends StatelessWidget {
  const CoffeCardWidget({super.key, required this.cardModel});
  final CoffeeItem cardModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            cardModel.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, right: 8),
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
                              Text(
                                " ${cardModel.rate}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(
                              flex: 1,
                            ),
                            Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              cardModel.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            Text(
                              cardModel.description
                                  .split(" ")
                                  .take(3)
                                  .join(" "),
                              style: const TextStyle(
                                  color: Color(0xffA2A2A2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(children: [
                              Text(
                                "\$${cardModel.sizes['medium']}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              CustomAddButton(
                                onTap: () {
                                  if (kDebugMode) {
                                    print("don`t press me again");
                                  }
                                },
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAddButton extends StatelessWidget {
  CustomAddButton({super.key, required this.onTap});

  void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xffC67C4E),
          ),
          child: const Center(
              child: Icon(
            Icons.add,
            color: Colors.white,
            size: 24,
          ))),
    );
  }
}
