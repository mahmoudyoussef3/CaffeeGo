import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseData = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.greyAppColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: AppColors.brownAppColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 46,
                        letterSpacing: 5),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                buildTextFormField('First Name', _firstNameController),
                const SizedBox(
                  height: 18,
                ),
                buildTextFormField('Last Name', _lastNameController),
                const SizedBox(
                  height: 18,
                ),
                buildTextFormField('Email', _emailController),
                const SizedBox(
                  height: 18,
                ),

                buildTextFormField('Phone Number', _phoneNumberController),
                const SizedBox(
                  height: 18,
                ),
                buildTextFormField('Password', _passwordController),
                const SizedBox(
                  height: 18,
                ),
                buildTextFormField(
                    'Confirm Password', _confirmPasswordController),
                const SizedBox(
                  height: 32,
                ),
                buildAuthButton('Register'),
                //
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildTextFormField(
      String labelText, TextEditingController controller) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
      ),
    );
  }

  Widget buildAuthButton(String buttonText) {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.brownAppColor)),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text);
            var user = userCredential.user;
            firebaseData.collection('users').doc(user!.uid).set({
              'firstName': _firstNameController.text,
              'lastName': _lastNameController.text,
              'email': _emailController.text,
              'uid': user.uid,
              'created_at': Timestamp.now(),
              'phoneNumber': _phoneNumberController.text,
            }).then(
              (value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Account Created Successfully')));
                Navigator.pushNamed(context, AppStrings.login);
              },
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
            }
          } catch (e) {
            print(e);
          }
        }
      },
      child: Text(
        buttonText,
        style: const TextStyle(
            color: AppColors.offWhiteAppColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 2),
      ),
    );
  }
}
