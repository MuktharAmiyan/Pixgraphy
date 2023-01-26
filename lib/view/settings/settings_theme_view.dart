import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/theme/extension/to_color.dart';
import 'package:pixgraphy/state/theme/extension/to_name.dart';
import 'package:pixgraphy/state/theme/model/app_seed_color.dart';
import 'package:pixgraphy/state/theme/theme_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

class SettingsThemeView extends ConsumerWidget {
  const SettingsThemeView({super.key});

  void toggleDarkMode(bool value, WidgetRef ref) {
    ref.read(themeProvider.notifier).changeBrightness(
          value ? Brightness.dark : Brightness.light,
        );
  }

  changeSeedColor(AppSeedColor seedColor, WidgetRef ref) {
    ref.read(themeProvider.notifier).changeAppSeedColor(seedColor);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themState = ref.watch(themeProvider);
    final isDark = themState.brightness == Brightness.dark;
    final seedColor = themState.seedColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appearance),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: const Text(Strings.darkMode),
            trailing: Switch(
              value: isDark,
              onChanged: (value) => toggleDarkMode(value, ref),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.accentColor,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List.generate(AppSeedColor.values.length, (index) {
                    final color = AppSeedColor.values[index];
                    return FilterChip(
                      label: Text(color.toName),
                      labelStyle: TextStyle(color: color.toColor),
                      selected: seedColor == color,
                      onSelected: (selectedSeedColor) =>
                          changeSeedColor(color, ref),
                    );
                  }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
