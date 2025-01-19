import 'dart:io';
import 'admin/main_admin.dart' as admin;
import 'User/main_user.dart' as user;

void main() {
  if (Platform.isWindows) {
    admin.main();
  } else {
    user.main();
  }
}
