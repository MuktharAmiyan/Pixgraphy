import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/theme/extension/to_color.dart';

import '../../route/route.dart';
import '../../state/theme/theme_provider.dart';

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
