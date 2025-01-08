import 'dart:async';

import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      Navigator.pushReplacementNamed(
        context,
        FirebaseAuth.instance.currentUser == null
            ? AppStrings.login
            : AppStrings.home,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 46,
              ),
              Image.asset(
                'assets/images/Image Onboarding.png',
              ),
              const SizedBox(
                height: 46,
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
              const SizedBox(height: 26),
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
            ],
          ),
        ),
      ),
    );
  }
}
