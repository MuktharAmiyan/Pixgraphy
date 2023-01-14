import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/notification/flutter_local_notifiaction.dart';
import 'package:pixgraphy/state/notification/model/recived_notification.dart';

final localPushNotificationProvider = Provider<LocalPushNotification>((ref) {
  final notificationsPlugin = ref.read(flutterLocalNotificationProvider);
  return LocalPushNotification(notificationsPlugin);
});

class LocalPushNotification {
  final FlutterLocalNotificationsPlugin notificationsPlugin;
  LocalPushNotification(
    this.notificationsPlugin,
  ) {
    _init();
  }

  void _init() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: DarwinInitializationSettings(requestAlertPermission: false));

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannelMax());

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        debugPrint(details.toString());
        //TODO NOTIFICATION NAVIGATION
      },
    );
  }

  void showNotifictaion(RecivedNotification notification) {
    notificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        NotificationDetails(
          android: _androidNotificationDetails(),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: notification.payload);
  }

  AndroidNotificationDetails _androidNotificationDetails() {
    return const AndroidNotificationDetails(
      '1001',
      'General Notification',
      importance: Importance.high,
      priority: Priority.max,
      channelDescription: 'This is general notificaton channel',
      channelShowBadge: true,
    );
  }

  AndroidNotificationChannel _androidNotificationChannelMax() {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    return channel;
  }
}
