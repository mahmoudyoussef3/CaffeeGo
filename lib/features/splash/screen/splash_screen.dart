import 'dart:developer';

import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:coffe_app/core/utils/widgets/custom_auth_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/Image Onboarding.png',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Fall in Love with\nCoffee in Blissful\nDelight!',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  letterSpacing: 3,
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Welcome to our cozy coffee corner, where\nevery cup is a delightful for you.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xffA2A2A2),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                height: 60,
                width: 300,
                child: CustomAuthButton(
                  buttonText: 'Get Started',
                  onPressed: () {
                    log("Get Started");
                    Navigator.pushNamed(context, AppStrings.home);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
