import 'package:coffe_app/Admin/main_admin.dart';
import 'package:coffe_app/core/utils/app_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/components/app_components.dart';
import '../../../data/authentication_methods.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool done;

  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: done
          ? () async {
              try {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>  Center(
                    child: AppComponents.customLoadingProgress()
                  ),
                );
                await AuthenticationMethods().signInWithGoogle();
                Navigator.pop(context);

                Navigator.pushNamed(context, AppStrings.home);
              } catch (e) {
                if (kDebugMode) {
                  print('Failed to sign in with Google: $e');
                }
                Navigator.pop(context);
                AppComponents.showSnackBar(
                    'Sign-in failed. Please try again.',
                    AppColorsDarkTheme.redAppColor,
                    context);
              }
            }
          : () {
        AppComponents.showToastMsg('In progress...');
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
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialButton(
            icon: FontAwesomeIcons.facebook,
            label: 'In progress',
            done: false,
          ),
          SocialButton(
            icon: FontAwesomeIcons.google,
            label: 'In progress',
            done: true,
          ),
        ],
      ),
    );
  }
}
