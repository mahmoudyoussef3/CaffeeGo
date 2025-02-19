import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalAdmin {
  Future<void> initPlatform() async {
    await OneSignal.shared.setAppId('3e076dbf-8eba-4b5e-840d-4d24f7980010');
    await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

    const externalUserId = 'admin@gmail.com';
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

  Future<void> sendNotificationToSpecificUser({
    required String title,
    required String message,
    required String userId,
  }) async {
    const String oneSignalUrl = "https://onesignal.com/api/v1/notifications";
    const String oneSignalAppId = '3e076dbf-8eba-4b5e-840d-4d24f7980010';
    const String oneSignalApiKey =
        'os_v2_app_hydw3p4oxjfv5banjusppgaacbw7gigs7xjeyze4gfnh54arpaydhjg6g2sjqcu5yyokv5jqknbjt3ksa5rskpxfozrvqxstlblarvy'; // Replace with your REST API key

    final body = {
      "app_id": oneSignalAppId,
      "headings": {"en": title},
      "contents": {"en": message},
      "include_external_user_ids": [userId],
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
        if (kDebugMode) {
          print('Notification sent successfully to $userId');
        }
      } else {
        if (kDebugMode) {
          print('Erroyyyyyyr: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exceptyyyyyyyyion: $e');
      }
    }
  }

  Future<void> sendNotificationToAllUsers({
    required String title,
    required String message,
    required String imgUrl,
  }) async {
    const String oneSignalUrl = "https://onesignal.com/api/v1/notifications";
    const String oneSignalAppId = '3e076dbf-8eba-4b5e-840d-4d24f7980010';
    const String oneSignalApiKey =
        'os_v2_app_hydw3p4oxjfv5banjusppgaacbw7gigs7xjeyze4gfnh54arpaydhjg6g2sjqcu5yyokv5jqknbjt3ksa5rskpxfozrvqxstlblarvy'; // Replace with your REST API key

    final body = {
      "app_id": oneSignalAppId,
      "headings": {"en": title},
      'included_segments': ['All'],
      "contents": {"en": message},
      "large_icon": "@mipmap/ic_launcher",
      "big_picture": imgUrl
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
      } else {
        if (kDebugMode) {
          print('Error: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
    }
  }
}
