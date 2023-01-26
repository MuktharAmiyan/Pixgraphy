import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/firebase_options.dart';
import 'package:pixgraphy/state/notification/services/firebase_push_notification.dart';
import 'view/my_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Pixgraphy',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final container = ProviderContainer();
  container.read(firebasePushNotificationProvider);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
