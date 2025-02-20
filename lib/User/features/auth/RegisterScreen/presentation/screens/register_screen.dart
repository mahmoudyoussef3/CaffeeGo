import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/User/features/auth/RegisterScreen/presentation/screens/widgets/have_account.dart';
import 'package:coffe_app/User/features/auth/RegisterScreen/presentation/screens/widgets/header_of_the_signup_screen.dart';
import 'package:coffe_app/User/features/auth/RegisterScreen/presentation/screens/widgets/register_text_fields.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/components/app_components.dart';
import '../../../CommonWidgets/background_img.dart';
import '../../../CommonWidgets/build_auth_button.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../login_screen/presentation/widgets/login_with_row.dart';
import '../../../login_screen/presentation/widgets/social_media_row.dart';

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
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const BackgroundImg(),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const HeaderOfTheSignupScreen(),
                    RegisterTextFields(
                      phoneNumberController: _phoneNumberController,
                      fullName: _fullName,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                    ),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          Navigator.pushNamed(context, AppStrings.home);
                          AppComponents.showSnackBar('Welcome, ${state.user.email!}!', Colors.green, context);

                        } else if (state is AuthError) {
                          AppComponents.showSnackBar(state.errorMessage,AppColorsDarkTheme.redAppColor, context);

                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return  AppComponents.customLoadingProgress();
                        }
                        return BuildAuthButton(
                            buttonText: 'Sign Up',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthCubit>().createAccount(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                      _phoneNumberController.text.trim(),
                                      _fullName.text.trim(),
                                    );
                              }
                            });
                      },
                    ),
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
      ),
    );
  }
}
