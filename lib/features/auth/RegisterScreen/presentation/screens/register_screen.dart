import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:coffe_app/features/auth/CommonWidgets/background_img.dart';
import 'package:coffe_app/features/auth/CommonWidgets/build_auth_button.dart';
import 'package:coffe_app/features/auth/RegisterScreen/presentation/screens/widgets/have_account.dart';
import 'package:coffe_app/features/auth/RegisterScreen/presentation/screens/widgets/header_of_the_signup_screen.dart';
import 'package:coffe_app/features/auth/RegisterScreen/presentation/screens/widgets/register_text_fields.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/widgets/login_with_row.dart';
import 'package:coffe_app/features/auth/login_screen/presentation/widgets/social_media_row.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _fullName.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const BackgroundImg(),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeaderOfTheSignupScreen(),
                  RegisterTextFields(),
                  _isLoading
                      ? const CustomLoadingProgress()
                      : BuildAuthButton(
                          buttonText: 'Sign Up',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text);
                                var user = userCredential.user;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user!.uid)
                                    .set({
                                  'displayName': _fullName.text,
                                  'email': _emailController.text,
                                  'uid': user.uid,
                                  'created_at': Timestamp.now(),
                                  'phoneNumber': _phoneNumberController.text,
                                  'cart': [],
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Account Created Successfully')));
                                Navigator.pushNamed(context, AppStrings.login);
                              } on FirebaseAuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor:
                                            const Color(0xff16181C),
                                        content: Text(
                                            style: const TextStyle(
                                                color: AppColors.brownAppColor),
                                            e.code == 'weak-password'
                                                ? 'The password provided is too weak.'
                                                : e.code ==
                                                        'email-already-in-use'
                                                    ? 'The account already exists for that email.'
                                                    : 'Failed to register.')));
                              } catch (e) {
                                print(e);
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            }
                          }),
                  SizedBox(height: 30.h),
                  const LoginWithRow(screen: 'Register'),
                  SizedBox(
                    height: 24.h,
                  ),
                  const SocialMediaRow(),
                  SizedBox(
                    height: 30.h,
                  ),
                  const HaveAccount(),
                  SizedBox(
                    height: 50.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
