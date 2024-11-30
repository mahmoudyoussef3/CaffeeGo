import 'package:coffe_app/core/utils/widgets/custom_auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';
class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
final _formatKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key:_formatKey ,
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                      color: AppColors.brownAppColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 46,
                      letterSpacing: 5),
                ),
                const SizedBox(
                  height: 32,
                ),
                 CustomTextFormField(
                    labelText: 'Email', controller: _emailController,),
                const SizedBox(
                  height: 18,
                ),
                 CustomTextFormField(
                  labelText: 'Password', controller: _passwordController,),
                const SizedBox(
                  height: 18,
                ),
                CustomAuthButton(buttonText:"Login", onPressed: ()async {
                  if(_formatKey.currentState!.validate()){
                    try {
                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text
                      );
                      Navigator.pushNamed(context, AppStrings.home);
                      print("${credential.user!.email}===============");
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }

                    }
                  }

                )
            ]),
                ),
        ),
    ),);
  }
}
