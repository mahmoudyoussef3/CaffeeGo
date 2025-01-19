import 'package:flutter/material.dart';
class BackgroundImg extends StatelessWidget {
  const BackgroundImg({super.key});

  @override
  Widget build(BuildContext context) {
    return  Opacity(
        opacity: 0.4,
        child: Image.asset('assets/onboarding_imgs/login.png'));
  }
}
