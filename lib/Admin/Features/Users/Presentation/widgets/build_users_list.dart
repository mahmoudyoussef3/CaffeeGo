import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class BuildUserList extends StatelessWidget {
  const BuildUserList({super.key, required this.userList});
  final List<UserDataClass> userList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return buildUserContainer(
            userList[index].name ?? 'Unknown',
            userList[index].email ?? 'No Email',
          );
        },
      ),
    );
  }

  Widget buildUserContainer(String name, String email) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: AppColors.brownAppColor,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
