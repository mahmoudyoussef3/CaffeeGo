import 'package:coffe_app/features/home/presentation/cubit/UserData_cubit/user_data_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildBannerWidget extends StatefulWidget {
  const BuildBannerWidget({super.key});

  @override
  State<BuildBannerWidget> createState() => _BuildBannerWidgetState();
}

class _BuildBannerWidgetState extends State<BuildBannerWidget> {
  @override
  void initState() {
    super.initState();
    context.read<UserDataClassCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10.0,
        left: 18.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserDataClassCubit, UserDataClassState>(
            builder: (context, state) {
              if (state is UserDataClassLoading) {
                return const Text('.....',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        fontFamily: 'Roboto'));
              }
              if (state is UserDataClassLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "Hello, ${state.userDataClass.name}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          fontFamily: 'Roboto'),
                    ),
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: NetworkImage(FirebaseAuth
                              .instance.currentUser!.photoURL ??
                          'https://c1.klipartz.com/pngpicture/314/450/sticker-png-circle-user-profile-avatar-computer-program-symbol-oval.png'),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            'Ready to start your day with a perfect cup of coffee?',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                height: 1.5,
                fontFamily: 'Roboto',
                color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
