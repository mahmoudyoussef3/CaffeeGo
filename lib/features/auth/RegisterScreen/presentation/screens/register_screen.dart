// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:coffe_app/core/utils/app_colors.dart';
// import 'package:coffe_app/core/utils/app_strings.dart';
// import 'package:coffe_app/core/utils/widgets/custom_text_form_field.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 5),
//                   Image.asset(
//                     'assets/images/app_img.png',
//                     height: 120,
//                   ),
//                   const SizedBox(height: 0),
//                   // App Name
//                   const Text(
//                     'CaféGo',
//                     style: TextStyle(
//                       color: AppColors.brownAppColor,
//                       letterSpacing: 2,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 36,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   const Text(
//                     'Create Account',
//                     style: TextStyle(
//                       fontFamily: 'Poppins',
//                       fontSize: 32,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.brownAppColor,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   CustomTextFormField(
//                     controller: _firstNameController,
//                     labelText: 'First Name',
//                     icon: Icons.person,
//                     hintText: 'Enter your first name',
//                     validator: (value) =>
//                         value!.isEmpty ? 'First name is required' : null,
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextFormField(
//                     controller: _lastNameController,
//                     labelText: 'Last Name',
//                     icon: Icons.person,
//                     hintText: 'Enter your last name',
//                     validator: (value) =>
//                         value!.isEmpty ? 'Last name is required' : null,
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextFormField(
//                     controller: _emailController,
//                     labelText: 'Email',
//                     icon: Icons.email,
//                     hintText: 'user.example@gmail.com',
//                     keyboardType: TextInputType.emailAddress,
//                     validator: (value) => value!.isEmpty ||
//                             !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                 .hasMatch(value)
//                         ? 'Enter a valid email'
//                         : null,
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextFormField(
//                     controller: _phoneNumberController,
//                     labelText: 'Phone Number',
//                     icon: Icons.phone,
//                     hintText: 'Enter your phone number',
//                     keyboardType: TextInputType.phone,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Phone number is required' : null,
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextFormField(
//                     controller: _passwordController,
//                     labelText: 'Password',
//                     icon: Icons.lock,
//                     hintText: 'Enter your password',
//                     obscureText: true,
//                     validator: (value) => value!.length < 6
//                         ? 'Password must be at least 6 characters'
//                         : null,
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextFormField(
//                     controller: _confirmPasswordController,
//                     labelText: 'Confirm Password',
//                     icon: Icons.lock,
//                     hintText: 'Confirm your password',
//                     obscureText: true,
//                     validator: (value) => value != _passwordController.text
//                         ? 'Passwords do not match'
//                         : null,
//                   ),
//                   const SizedBox(height: 32),
//                   _isLoading
//                       ? const CircularProgressIndicator(
//                           color: AppColors.brownAppColor,
//                         )
//                       : buildAuthButton('Register'),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildAuthButton(String buttonText) {
//     return ElevatedButton(
//       onPressed: _isLoading
//           ? null
//           : () async {
//               if (_formKey.currentState!.validate()) {
//                 setState(() {
//                   _isLoading = true;
//                 });
//                 try {
//                   UserCredential userCredential = await FirebaseAuth.instance
//                       .createUserWithEmailAndPassword(
//                           email: _emailController.text,
//                           password: _passwordController.text);
//                   var user = userCredential.user;
//                   await FirebaseFirestore.instance
//                       .collection('users')
//                       .doc(user!.uid)
//                       .set({
//                     'displayName':
//                         _firstNameController.text + _lastNameController.text,
//                     'email': _emailController.text,
//                     'uid': user.uid,
//                     'created_at': Timestamp.now(),
//                     'phoneNumber': _phoneNumberController.text,
//                     'cart': []
//                   });
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text('Account Created Successfully')));
//                   Navigator.pushNamed(context, AppStrings.login);
//                 } on FirebaseAuthException catch (e) {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text(e.code == 'weak-password'
//                           ? 'The password provided is too weak.'
//                           : e.code == 'email-already-in-use'
//                               ? 'The account already exists for that email.'
//                               : 'Failed to register.')));
//                 } catch (e) {
//                   print(e);
//                 } finally {
//                   setState(() {
//                     _isLoading = false;
//                   });
//                 }
//               }
//             },
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:coffe_app/core/utils/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Stack(
        children: [
          Opacity(
              opacity: 0.4,
              child: Image.asset('assets/onboarding_imgs/login.png')),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
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
                  'Register your Account',
                  style: TextStyle(
                      color: AppColors.offWhiteAppColor,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 30),
                CustomTextFormField(
                  controller: _fullName,
                  labelText: 'Full Name',
                  icon: Icons.person,
                  hintText: 'Enter your full name',
                  validator: (value) =>
                      value!.isEmpty ? 'Name is required' : null,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  controller: _emailController,
                  labelText: 'E-mail Address',
                  icon: Icons.email,
                  hintText: 'user.example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  hintText: 'Enter your password',
                  obscureText: true,
                  validator: (value) => value!.length < 6
                      ? 'Password must be at least 6 characters'
                      : null,
                ),
                const SizedBox(height: 12),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  icon: Icons.lock,
                  hintText: 'Confirm your password',
                  obscureText: true,
                  validator: (value) => value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                ),
                const SizedBox(height: 32),
                _isLoading
                    ? const CircularProgressIndicator(
                        color: AppColors.brownAppColor,
                      )
                    : buildAuthButton('Register'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 55,
                      child: const Divider(
                        color: AppColors.brownAppColor,
                        endIndent: 5,
                      ),
                    ),
                    const Text(
                      'Or Register with',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 55,
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
                                    style: TextStyle(
                                        color: AppColors.brownAppColor),
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
                                    style: TextStyle(
                                        color: AppColors.brownAppColor),
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
                                    style: TextStyle(
                                        color: AppColors.brownAppColor),
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
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ? ",
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
                        Navigator.pushNamed(context, AppStrings.login);
                      },
                      child: const Text(
                        'Login',
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
        ],
      ),
    );
  }

  Widget buildAuthButton(String buttonText) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
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
                      'cart': []
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Account Created Successfully')));
                    Navigator.pushNamed(context, AppStrings.login);
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: const Color(0xff16181C),
                        content: Text(
                            style:
                                const TextStyle(color: AppColors.brownAppColor),
                            e.code == 'weak-password'
                                ? 'The password provided is too weak.'
                                : e.code == 'email-already-in-use'
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
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
