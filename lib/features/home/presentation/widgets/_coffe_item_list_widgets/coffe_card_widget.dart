import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: 5.0.h,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 200.h,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 120.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.r),
                                  topLeft: Radius.circular(12.r)),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0.w, vertical: 4.h),
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              cardModel.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                            child: Text(
                              cardModel.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Color(0xffA2A2A2),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            child: Row(children: [
                              Text(
                                "\$${cardModel.sizes['medium']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
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
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
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
