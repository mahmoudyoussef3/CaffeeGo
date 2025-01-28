import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/features/auth/data/authentication_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/utils/app_colors.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;

  SocialButton({
    super.key,
    required this.icon,
    required this.label,
  });
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await AuthenticationMethods().signInWithGoogle();

          Navigator.pushNamed(context, AppStrings.home);
        } catch (e) {
          print('Failed to sign in with Google: $e');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign-in failed. Please try again.')));
        }
      },
      child: Container(
        width: 80.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: const Color(0xff16181C),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SocialButton(
            icon: FontAwesomeIcons.facebook,
            label: 'In progress',
          ),
          SocialButton(
            icon: FontAwesomeIcons.google,
            label: 'In progress',
          ),
          SocialButton(
            icon: FontAwesomeIcons.twitter,
            label: 'In progress',
          ),
        ],
      ),
    );
  }
}
