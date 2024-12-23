import 'dart:developer';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:coffe_app/core/utils/widgets/custom_auth_button.dart';

import '../../payment/wallet_payment.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/Image Onboarding.png',
              ),
              const Text(
                'Fall in Love with\nCoffee in Blissful\nDelight!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 3,
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Welcome to our cozy coffee corner, where\nevery cup is a delightful for you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xffA2A2A2),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 60,
                width: 300,
                child: CustomAuthButton(
                  buttonText: 'Get Started',
                  onPressed: () {
                    Navigator.pushNamed(context, AppStrings.login);
                  },
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          ),
        ),
      ),
    );
  }
}
