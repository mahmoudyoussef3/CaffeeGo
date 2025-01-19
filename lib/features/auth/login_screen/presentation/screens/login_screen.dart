import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:coffe_app/features/auth/CommonWidgets/build_auth_button.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/widgets/don%60t_have_an_account.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/widgets/forgot_password.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/widgets/header_of_the_login_screen.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/widgets/login_text_fields.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/widgets/login_with_row.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/widgets/social_media_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../CommonWidgets/background_img.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(children: [
          const BackgroundImg(),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeaderOfTheLoginScreen(),
                LoginTextFields(),
                SizedBox(
                  height: 12.h,
                ),
                const ForgotPassword(),
                SizedBox(height: 30.h),
                isLoading
                    ? const CustomLoadingProgress()
                    : BuildAuthButton(
                        buttonText: 'Sign in',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());

                              Navigator.pushNamed(context, AppStrings.home);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "${credential.user!.email} logged in successfully.",
                                  style: const TextStyle(
                                      color: AppColors.brownAppColor),
                                ),
                              ));
                              setState(() {
                                isLoading = false;
                              });
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              String errorMessage;
                              if (e.code == 'user-not-found') {
                                errorMessage =
                                    'No account found with this email. Please sign up.';
                              } else if (e.code == 'wrong-password') {
                                errorMessage =
                                    'Incorrect password. Please try again.';
                              } else {
                                errorMessage =
                                    'An error occurred: ${e.message}';
                              }
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }
                        }),
                SizedBox(height: 30.h),
                const LoginWithRow(
                  screen: 'Login',
                ),
                SizedBox(
                  height: 24.h,
                ),
                const SocialMediaRow(),
                SizedBox(
                  height: 30.h,
                ),
                const DoNotHaveAnAccount(),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
