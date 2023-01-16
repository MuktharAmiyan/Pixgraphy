import 'dart:convert' show json, Encoding;
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pixgraphy/state/notification/model/send_notification.dart';
import '../../../api_keys.dart';

final notificationrepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository();
});

class NotificationRepository {
  NotificationRepository();
  final postUrl = 'https://fcm.googleapis.com/fcm/send';
  final headers = {
    'content-type': 'application/json',
    'Authorization': cloudMessagingAPIKey,
  };

  void sendNotificationToAUser(SendNotification notification) async {
    final data = {
      "notification": {
        "body": notification.body,
        "title": notification.title,
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to": notification.token,
    };
    try {
      final response = await http.post(Uri.parse(postUrl),
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers);

      if (response.statusCode == 200) {
        // on success do sth
        log("Done");
      } else {
        log("NOT Done");
        // on failure do sth
      }
    } catch (_) {
      return;
    }
  }
}
