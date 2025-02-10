// import 'package:coffe_app/Admin/Features/Users/Presentation/cubits/get_all_users_cubit/get_all_users_cubit.dart';
// import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../../core/utils/app_colors.dart';
//
// class ManageUsersScreen extends StatefulWidget {
//   const ManageUsersScreen({super.key});
//
//   @override
//   State<ManageUsersScreen> createState() => _ManageUsersScreenState();
// }
//
// class _ManageUsersScreenState extends State<ManageUsersScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<GetAllUsersCubit>().getAllUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           foregroundColor: AppColors.offWhiteAppColor,
//           title: const Text('Manage Users'),
//           backgroundColor: AppColors.brownAppColor,
//         ),
//         body: BlocBuilder<GetAllUsersCubit, GetAllUsersState>(
//           builder: (context, state) {
//             if (state is GetAllUsersLoading) {
//               return Center(
//                 child: CustomLoadingProgress(),
//               );
//             }
//             if (state is GetAllUsersFailure) {
//               return Center(
//                 child: Text('Error fetching users'),
//               );
//             }
//             if (state is GetAllUsersSuccess) {
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16.0),
//                 itemCount: state.users.length,
//                 itemBuilder: (context, index) {
//                   return _buildUserCard(
//                       context,
//                       state.users[index].name ?? 'UnKnown',
//                       state.users[index].email!);
//                 },
//               );
//             }
//             return SizedBox.shrink();
//           },
//         ));
//   }
//
//   Widget _buildUserCard(BuildContext context, String name, String email) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 16),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: AppColors.brownAppColor,
//           child: const Icon(Icons.person, color: Colors.white),
//         ),
//         title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(email),
//       ),
//     );
//   }
// }
import 'package:coffe_app/Admin/Features/Users/Presentation/cubits/get_all_users_cubit/get_all_users_cubit.dart';
import 'package:coffe_app/core/utils/widgets/custom_loading_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/utils/app_colors.dart';

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
            return const Center(child: CustomLoadingProgress());
          }
          if (state is GetAllUsersFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animations/error.json', width: 150),
                  const SizedBox(height: 10),
                  const Text(
                    'Error fetching users',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
            );
          }
          if (state is GetAllUsersSuccess) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return _buildUserCard(
                    state.users[index].name ?? 'Unknown',
                    state.users[index].email ?? 'No Email',
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildUserCard(String name, String email) {
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
