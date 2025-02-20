import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../app_colors.dart';

abstract class AppComponents {
  static showSnackBar(String text, Color color, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: color,
          content: Text(
            text,
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  static void showToastMsg(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColorsDarkTheme.greyAppColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  static Widget customLoadingProgress() {
    return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: AppColors.brownAppColor,
      size: 50,
    ));
  }
}
