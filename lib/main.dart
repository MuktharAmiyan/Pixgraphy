import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/firebase_options.dart';
import 'package:pixgraphy/route/route.dart';
import 'package:pixgraphy/state/notification/services/firebase_push_notification.dart';
import 'package:pixgraphy/state/theme/extension/to_color.dart';
import 'package:pixgraphy/state/theme/theme_provider.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouteProvider);
    final themeState = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Pixgraphy',
      theme: ThemeData(
        useMaterial3: true,
        brightness: themeState.brightness,
        colorScheme: themeState.seedColor.toColor == null
            ? null
            : ColorScheme.fromSeed(
                seedColor: themeState.seedColor.toColor!,
                brightness: themeState.brightness,
              ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
