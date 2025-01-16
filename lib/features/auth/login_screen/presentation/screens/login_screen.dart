// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../core/utils/app_colors.dart';
// import '../../../../../core/utils/app_strings.dart';
// import '../../../../../core/utils/widgets/custom_text_form_field.dart';
//
// class LoginScreen extends StatefulWidget {
//   LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _emailController = TextEditingController();
//
//   final TextEditingController _passwordController = TextEditingController();
//
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 50),
//                 Image.asset(
//                   'assets/images/app_img.png',
//                   height: 120,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'CaféGo',
//                   style: TextStyle(
//                     color: AppColors.brownAppColor,
//                     letterSpacing: 2,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 36,
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 CustomTextFormField(
//                   labelText: 'Email',
//                   controller: _emailController,
//                   icon: Icons.email,
//                   hintText: 'Enter your email',
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Email is required';
//                     }
//                     if (!RegExp(
//                             r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
//                         .hasMatch(value)) {
//                       return 'Enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 18),
//                 CustomTextFormField(
//                   labelText: 'Password',
//                   controller: _passwordController,
//                   icon: Icons.lock,
//                   hintText: 'Enter your password',
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Password is required';
//                     }
//                     if (value.length < 6) {
//                       return 'Password must be at least 6 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 30),
//                 isLoading
//                     ? const CircularProgressIndicator(
//                         color: AppColors.brownAppColor,
//                       )
//                     : buildAuthButton(
//                         'Login',
//                       ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Don't have an account? ",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(context, AppStrings.signup);
//                       },
//                       child: const Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: AppColors.brownAppColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildAuthButton(
//     String buttonText,
//   ) {
//     return ElevatedButton(
//       onPressed: () async {
//         if (_formKey.currentState!.validate()) {
//           setState(() {
//             isLoading = true;
//           });
//           try {
//             final credential = await FirebaseAuth.instance
//                 .signInWithEmailAndPassword(
//                     email: _emailController.text.trim(),
//                     password: _passwordController.text.trim());
//
//             Navigator.pushNamed(context, AppStrings.home);
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content:
//                   Text("${credential.user!.email} logged in successfully."),
//               backgroundColor: Colors.green,
//             ));
//             setState(() {
//               isLoading = false;
//             });
//           } on FirebaseAuthException catch (e) {
//             setState(() {
//               isLoading = false;
//             });
//             String errorMessage;
//             if (e.code == 'user-not-found') {
//               errorMessage =
//                   'No account found with this email. Please sign up.';
//             } else if (e.code == 'wrong-password') {
//               errorMessage = 'Incorrect password. Please try again.';
//             } else {
//               errorMessage = 'An error occurred: ${e.message}';
//             }
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               content: Text(errorMessage),
//               backgroundColor: Colors.red,
//             ));
//           }
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppColors.brownAppColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         minimumSize: const Size(double.infinity, 50),
//       ),
//       child: Text(
//         buttonText,
//         style: const TextStyle(
//           fontFamily: 'Poppins',
//           color: Colors.white,
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

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
      body: Stack(children: [
        Opacity(
            opacity: 0.4,
            child: Image.asset('assets/onboarding_imgs/login.png')),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Image.asset(
                  'assets/onboarding_imgs/Vector.png',
                  // height: 120,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to Login',
                style: TextStyle(
                    color: AppColors.offWhiteAppColor,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 40),
              CustomTextFormField(
                labelText: 'E-mail Address',
                controller: _emailController,
                icon: Icons.email,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(
                          r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
                      .hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              CustomTextFormField(
                labelText: 'Password',
                controller: _passwordController,
                icon: Icons.lock,
                hintText: 'Enter your password',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Text('Forgot Password ?',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        decorationColor: AppColors.brownAppColor,
                        color: AppColors.brownAppColor,
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      )),
                ),
              ),
              const SizedBox(height: 30),
              isLoading
                  ? const CircularProgressIndicator(
                      color: AppColors.brownAppColor,
                    )
                  : buildAuthButton(
                      'Sign in',
                    ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 45,
                    child: const Divider(
                      color: AppColors.brownAppColor,
                      endIndent: 5,
                    ),
                  ),
                  const Text(
                    'Or Login with',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 45,
                    child: const Divider(
                      color: AppColors.brownAppColor,
                      indent: 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Color(0xff16181C),
                                content: Text(
                                  'In progress',
                                  style:
                                      TextStyle(color: AppColors.brownAppColor),
                                )));
                      },
                      child: Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xff16181C),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Color(0xff16181C),
                                content: Text(
                                  'In progress',
                                  style:
                                      TextStyle(color: AppColors.brownAppColor),
                                )));
                      },
                      child: Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xff16181C),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                backgroundColor: Color(0xff16181C),
                                content: Text(
                                  'In progress',
                                  style:
                                      TextStyle(color: AppColors.brownAppColor),
                                )));
                      },
                      child: Container(
                        width: 80,
                        height: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xff16181C),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account ? ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppStrings.signup);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.brownAppColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget buildAuthButton(
    String buttonText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            try {
              final credential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim());

              Navigator.pushNamed(context, AppStrings.home);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "${credential.user!.email} logged in successfully.",
                  style: const TextStyle(color: AppColors.brownAppColor),
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
                errorMessage = 'Incorrect password. Please try again.';
              } else {
                errorMessage = 'An error occurred: ${e.message}';
              }
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ));
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brownAppColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            letterSpacing: 1,
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
