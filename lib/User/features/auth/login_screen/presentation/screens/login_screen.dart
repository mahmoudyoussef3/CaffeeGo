import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../CommonWidgets/background_img.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../CommonWidgets/build_auth_button.dart';
import '../../../cubit/auth_cubit.dart';
import '../widgets/don`t_have_an_account.dart';
import '../widgets/forgot_password.dart';
import '../widgets/header_of_the_login_screen.dart';
import '../widgets/login_text_fields.dart';
import '../widgets/login_with_row.dart';
import '../widgets/social_media_row.dart';

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
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: SingleChildScrollView(
          child: Stack(children: [
            const BackgroundImg(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const HeaderOfTheLoginScreen(),
                  LoginTextFields(
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  const ForgotPassword(),
                  SizedBox(height: 30.h),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushNamed(context, AppStrings.home);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Welcome, ${state.user.email!}!')),
                        );
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CustomLoadingProgress());
                      }
                      return BuildAuthButton(
                        buttonText: 'Sign in',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<AuthCubit>()
                                .signInWithEmailAndPassword(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );
                          }
                        },
                      );
                    },
                  ),
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
      ),
    );
  }
}
