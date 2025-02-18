import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTopContainer extends StatelessWidget {
  const BuildTopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColorsDarkTheme.greyAppColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/icons/drawer_icon.png'),
            ),
          ),
        ),
        IconButton(
          icon: CircleAvatar(
            foregroundColor: Colors.transparent,
            radius: 20.r,
            backgroundImage: NetworkImage(FirebaseAuth
                    .instance.currentUser!.photoURL ??
                'https://c1.klipartz.com/pngpicture/314/450/sticker-png-circle-user-profile-avatar-computer-program-symbol-oval.png'),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
