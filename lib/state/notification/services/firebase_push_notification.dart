import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_messaging.dart';
import 'package:pixgraphy/state/notification/model/recived_notification.dart';
import 'package:pixgraphy/state/notification/services/local_push_notification.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint("Handling a background message: ${message.messageId}");
}

final firebasePushNotificationProvider =
    Provider<FirebasePushNotification>((ref) {
  final messaging = ref.read(firebaseMessagingProvider);
  final notification = ref.read(localPushNotificationProvider);
  return FirebasePushNotification(messaging, notification);
});

class FirebasePushNotification {
  final FirebaseMessaging messaging;
  final LocalPushNotification localPushNotification;
  FirebasePushNotification(this.messaging, this.localPushNotification) {
    _init();
    _onFirebaseMessageRecived();
  }
  void _init() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    messaging.getInitialMessage();
  }

  void _onFirebaseMessageRecived() async {
    FirebaseMessaging.onMessage.listen(
      (message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        Map<String, dynamic> data = message.data;
        if (notification != null && android != null) {
          localPushNotification.showNotifictaion(
            RecivedNotification(
              id: notification.hashCode,
              title: notification.title,
              body: notification.body,
              payload: jsonEncode(data),
            ),
          );
        }
      },
    );
  }
}
