import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/theme/extension/to_color.dart';
import 'package:pixgraphy/state/theme/model/app_seed_color.dart';
import 'package:pixgraphy/state/theme/theme_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

class SettingsThemeView extends ConsumerWidget {
  const SettingsThemeView({super.key});

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
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ExpansionTile(
                title: const Text(Strings.themeMode),
                children: [
                  ListTile(
                    title: const Text(Strings.dark),
                    selected: isDark,
                    onTap: () =>
                        ref.read(themeProvider.notifier).changeBrightness(
                              Brightness.dark,
                            ),
                  ),
                  ListTile(
                    title: const Text(Strings.light),
                    selected: !isDark,
                    onTap: () =>
                        ref.read(themeProvider.notifier).changeBrightness(
                              Brightness.light,
                            ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ExpansionTile(
                title: const Text(Strings.accentColor),
                children: List.generate(AppSeedColor.values.length, (index) {
                  final appSeedColor = AppSeedColor.values[index];
                  return ListTile(
                    title: Text(appSeedColor.name),
                    selected: seedColor == appSeedColor,
                    onTap: () => ref
                        .read(themeProvider.notifier)
                        .changeAppSeedColor(appSeedColor),
                    leading: CircleAvatar(
                      backgroundColor: appSeedColor.toColor.withOpacity(0.5),
                      radius: 10,
                      child: const SizedBox(
                        height: 15,
                        width: 15,
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
