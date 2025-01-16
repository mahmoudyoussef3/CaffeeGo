// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class AdminDashboard extends StatefulWidget {
//   const AdminDashboard({super.key});
//
//   @override
//   State<AdminDashboard> createState() => _AdminDashboardState();
// }
//
// class _AdminDashboardState extends State<AdminDashboard> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _messageController = TextEditingController();
//   final TextEditingController _userIdController = TextEditingController();
//   Future<void> sendNotification({
//     required String title,
//     required String message,
//     required BuildContext context,
//     List<String>? userIds,
//   }) async {
//     const String oneSignalUrl = "https://onesignal.com/api/v1/notifications";
//     const String oneSignalAppId = '3e076dbf-8eba-4b5e-840d-4d24f7980010';
//     const String oneSignalApiKey =
//         'os_v2_app_hydw3p4oxjfv5banjusppgaacbw7gigs7xjeyze4gfnh54arpaydhjg6g2sjqcu5yyokv5jqknbjt3ksa5rskpxfozrvqxstlblarvy'; // Replace with your REST API key
//
//     if (userIds == null || userIds.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error: No target users specified.')),
//       );
//       return;
//     }
//
//     final body = {
//       "app_id": oneSignalAppId,
//       "headings": {"en": title},
//       'included_segments': ['All'],
//
//       "contents": {"en": message},
//       // "include_external_user_ids": userIds, // Target specific users
//     };
//
//     try {
//       final response = await http.post(
//         Uri.parse(oneSignalUrl),
//         headers: {
//           "Content-Type": "application/json; charset=utf-8",
//           "Authorization": "Basic $oneSignalApiKey",
//         },
//         body: json.encode(body),
//       );
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Notification sent successfully!')),
//         );
//       } else {
//         print('Error: ${response.body}');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${response.body}')),
//         );
//       }
//     } catch (e) {
//       print('Exception: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Exception: $e')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Admin Dashboard')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Notification Title',
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _messageController,
//               decoration: const InputDecoration(
//                 labelText: 'Notification Message',
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: _userIdController,
//               decoration: const InputDecoration(
//                 labelText: 'User ID (optional)',
//                 hintText: 'Leave empty to send to all users',
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final title = _titleController.text.trim();
//                 final message = _messageController.text.trim();
//                 final userId = _userIdController.text.trim();
//
//                 if (title.isEmpty || message.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                       content: Text('Title and Message required')));
//                   return;
//                 }
//
//                 sendNotification(
//                   title: title,
//                   message: message,
//                   userIds: [userId],
//                   context: context,
//                 );
//               },
//               child: const Text('Send Notification'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
