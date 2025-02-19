import 'package:coffe_app/User/features/home/presentation/cubit/UserData_cubit/user_data_cubit.dart';
import 'package:coffe_app/User/features/home/presentation/widgets/_drawer_widgets/build_logout_dialoug.dart';
import 'package:coffe_app/core/utils/app_colors.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    context.read<UserDataClassCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UserDataClassCubit, UserDataClassState>(
          builder: (context, state) {
            if (state is UserDataClassLoading) {
              return const Center(
                child: CustomLoadingProgress(),
              );
            } else if (state is UserDataClassError) {
              return const Center(
                child: Text(
                  'An error occurred while fetching data.',
                  style: TextStyle(color: AppColorsDarkTheme.redAppColor),
                ),
              );
            } else if (state is UserDataClassLoaded) {
              var userData = state.userDataClass;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: AppColorsDarkTheme.whiteAppColor),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Stack(children: [
                      CircleAvatar(
                        radius: 75,
                        backgroundColor: AppColorsDarkTheme.redAppColor,
                        backgroundImage: NetworkImage(FirebaseAuth
                                .instance.currentUser!.photoURL ??
                            'https://c1.klipartz.com/pngpicture/314/450/sticker-png-circle-user-profile-avatar-computer-program-symbol-oval.png'),
                      ),
                      const Positioned(
                          bottom: 0,
                          right: 10,
                          child: InkWell(
                            child: Icon(
                              Icons.edit,
                              color: AppColorsDarkTheme.whiteAppColor,
                            ),
                          ))
                    ]),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    Divider(color: Colors.grey[800]),
                    const SizedBox(height: 20),
                    buildProfileOption(
                      icon: Icons.person,
                      title: userData.name ?? 'UNKnown user',
                    ),
                    buildProfileOption(
                      icon: Icons.email,
                      title: userData.email ?? 'No mail provided',
                    ),
                    buildProfileOption(
                      icon: Icons.phone,
                      title: userData.phoneNumber ?? '01204154971',
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColorsDarkTheme.redAppColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => buildTheDialogOfLogout(context),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  void buildTheDialogOfLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const BuildLogoutDialog();
      },
    );
  }

  Widget buildProfileOption({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColorsDarkTheme.greyAppColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon,
                  color: AppColorsDarkTheme.greyLessDegreeAppColor, size: 28),
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
