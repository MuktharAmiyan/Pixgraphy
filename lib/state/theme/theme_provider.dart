import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/theme/model/theme_state.dart';
import 'package:pixgraphy/state/theme/notifier/theme_notifier.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (_) => ThemeNotifier(),
);
