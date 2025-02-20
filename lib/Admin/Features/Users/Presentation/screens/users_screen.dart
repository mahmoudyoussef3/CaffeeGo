
import 'package:coffe_app/Admin/Features/Users/Presentation/cubits/get_all_users_cubit/get_all_users_cubit.dart';
import 'package:coffe_app/Admin/Features/Users/Presentation/widgets/build_users_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/components/app_components.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetAllUsersCubit>().getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.offWhiteAppColor,
        appBar: AppBar(
          centerTitle: true,
          foregroundColor: Colors.white,
          title: const Text(
            'Manage Users',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.brownAppColor,
          elevation: 4,
        ),
        body: BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
            builder: (context, state) {
          if (state is GetAllUsersLoading) {
            return Center(child: AppComponents.customLoadingProgress());
          }
          if (state is GetAllUsersFailure) {
            return const Center(
              child: Text(
                'Error fetching users',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            );
          }
          if (state is GetAllUsersSuccess) {
            return BuildUserList(userList: state.users);
          }
          return const Center(
            child: Text(
              'No users available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          );
        }));
  }
}
