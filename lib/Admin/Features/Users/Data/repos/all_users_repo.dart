import 'package:coffe_app/Admin/Features/Users/Data/data_source/get_all_users.dart';
import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';

class AllUsersRepo {

  AllUsersRepo();

  Future<List<UserDataClass>> getUsers() async {
    return await GetAllUsers().getAllUsers();
  }
}
