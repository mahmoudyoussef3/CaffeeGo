import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';

class CoffeeCardWidget extends StatelessWidget {
  const CoffeeCardWidget({super.key, required this.cardModel});
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 140,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  topLeft: Radius.circular(12)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: cardModel.image,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fadeInDuration:
                                    const Duration(milliseconds: 1000),
                                fadeOutDuration:
                                    const Duration(milliseconds: 1000),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5),
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              cardModel.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              cardModel.description
                              // .split(" ")
                              // .take(3)
                              // .join(" "),
                              ,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: Color(0xffA2A2A2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(children: [
                              Text(
                                "\$${cardModel.sizes['medium']}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Spacer(),
                              Row(children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  " ${cardModel.rate}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ]),
                            ]),
                          ),
                        ],
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
