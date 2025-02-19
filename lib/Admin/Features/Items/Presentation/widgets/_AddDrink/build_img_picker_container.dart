import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

class BuildImgPickerContainer extends StatelessWidget {
  const BuildImgPickerContainer(
      {super.key, required this.pickImg, required this.image});
  final Function() pickImg;
  final File? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickImg();
      },
      child: Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.brown.shade100,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.offWhiteAppColor, width: 2),
          ),
          child: image == null
              ? const Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.black,
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(image!,
                      height: 250, width: double.infinity, fit: BoxFit.cover),
                )),
    );
  }
}
