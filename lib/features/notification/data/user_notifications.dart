import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalUser {
  final String externalUserId;
  final String userName;
  OneSignalUser({required this.externalUserId, required this.userName});
  Future<void> initPlatform() async {
    await OneSignal.shared.setAppId('3e076dbf-8eba-4b5e-840d-4d24f7980010');
    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);

    if (externalUserId.isNotEmpty) {
      await OneSignal.shared.setExternalUserId(externalUserId).then((value) {
        log('External User ID Set: $externalUserId');
      });
    } else {
      await OneSignal.shared.setExternalUserId(externalUserId).then((value) {
        log('External User ID Cleared');
      });
    }

    await OneSignal.shared.getDeviceState().then((value) {
      log('Device User ID: ${value?.userId}');
    });
  }

  Future<void> sendNotificationToAdmin() async {
    const String oneSignalUrl = "https://onesignal.com/api/v1/notifications";
    const String oneSignalAppId = '3e076dbf-8eba-4b5e-840d-4d24f7980010';
    const String oneSignalApiKey =
        'os_v2_app_hydw3p4oxjfv5banjusppgaacbw7gigs7xjeyze4gfnh54arpaydhjg6g2sjqcu5yyokv5jqknbjt3ksa5rskpxfozrvqxstlblarvy'; // Replace with your REST API key
    final body = {
      "app_id": oneSignalAppId,
      "headings": {"en": 'You have new order from $userName'},
      "contents": {"en": 'message'},
      "include_external_user_ids": ['admin@gmail.com'],
    };

    try {
      final response = await http.post(
        Uri.parse(oneSignalUrl),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": "Basic $oneSignalApiKey",
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
