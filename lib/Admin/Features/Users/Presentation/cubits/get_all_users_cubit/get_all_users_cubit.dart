import 'package:coffe_app/Admin/Features/Users/Data/repos/all_users_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../User/features/home/data/models/UserData/user_data.dart';

part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit(this.allUsersRepo) : super(GetAllUsersInitial());
  AllUsersRepo allUsersRepo;

  Future getAllUsers() async {
    emit(GetAllUsersLoading());
    try {
      List<UserDataClass> userData = await allUsersRepo.getUsers();
      emit(GetAllUsersSuccess(users: userData));
      return;
    } catch (e) {
      emit(GetAllUsersFailure(error: e.toString()));
      return;
    }
  }
}
