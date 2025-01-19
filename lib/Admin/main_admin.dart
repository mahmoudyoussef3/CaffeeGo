import 'package:coffe_app/test_admin/admin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Admin App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const AdminDashboard());
  }
}
