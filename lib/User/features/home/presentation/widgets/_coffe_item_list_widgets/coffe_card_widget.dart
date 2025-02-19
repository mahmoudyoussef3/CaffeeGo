import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/coffe_item.dart';

class CoffeeCardWidget extends StatelessWidget {
  const CoffeeCardWidget({super.key, required this.cardModel});
  final CoffeeItem cardModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          gradient: const LinearGradient(
              colors: [Color(0xff252A32), AppColorsDarkTheme.darkBlueAppColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 5.0.h,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.r)),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: cardModel.image,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fadeInDuration:
                                    const Duration(milliseconds: 1000),
                              ),
                            ),
                          ),
                          const Spacer(

                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0.w, vertical: 4.h),
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              cardModel.name,
                              style: TextStyle(
                                  color: AppColorsDarkTheme.whiteAppColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500),
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
                                  color: const Color(0xffA2A2A2),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500),
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
                              Text.rich(
                                TextSpan(
                                  text: "\$ ",
                                  style: TextStyle(
                                      color: AppColorsDarkTheme.brownAppColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${cardModel.sizes['medium']} ', // Bold part
                                      style: TextStyle(
                                          color:
                                              AppColorsDarkTheme.whiteAppColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Row(children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColorsDarkTheme.brownAppColor,
                                ),
                                Text(
                                  " ${cardModel.rate}",
                                  style: TextStyle(
                                      color: AppColorsDarkTheme.whiteAppColor,
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
