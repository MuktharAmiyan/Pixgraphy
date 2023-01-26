import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/theme/extension/to_color.dart';
import 'package:pixgraphy/state/theme/extension/to_name.dart';
import 'package:pixgraphy/view/components/app_logo/app_logo.dart';
import 'package:pixgraphy/view/components/constants/asset_path.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

import '../../state/auth/notifier/auth_state_notifier.dart';
import '../../state/theme/model/app_seed_color.dart';
import '../../state/theme/theme_provider.dart';

class LandingView extends ConsumerWidget {
  const LandingView({super.key});

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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: isDark
              ? const AssetImage(AssetPath.landingBgDark)
              : const AssetImage(AssetPath.landingBgLight),
          fit: BoxFit.cover,
        )),
        child: ListView(
          padding: const EdgeInsets.all(8),
          physics: const BouncingScrollPhysics(),
          children: [
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => toggleDarkMode(!isDark, ref),
                    icon: isDark
                        ? const Icon(Icons.light_mode_outlined)
                        : const Icon(Icons.dark_mode),
                  ),
                  PopupMenuButton<AppSeedColor>(
                    initialValue: seedColor,
                    onSelected: (color) => changeSeedColor(color, ref),
                    itemBuilder: (context) => List.generate(
                      AppSeedColor.values.length,
                      (index) {
                        final color = AppSeedColor.values[index];
                        return PopupMenuItem(
                          value: color,
                          child: ListTile(
                            leading: Icon(
                              Icons.colorize,
                              color: color.toColor,
                            ),
                            title: Text(color.toName),
                          ),
                        );
                      },
                    ),
                    child: const Icon(Icons.color_lens_outlined),
                  )
                ],
              ),
            ),
            const AppLogo(
              size: 65,
            ),
            const SizedBox(
              height: 110,
            ),
            Text(
              Strings.smallLandingDes,
              style: Theme.of(context).textTheme.headlineMedium,
              // textAlign: TextAlign.center,
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_downward_outlined,
                size: 50,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              Strings.detailLandingDes,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                        minimumSize: const Size(200, 54)),
                    onPressed:
                        ref.read(authStateProvider.notifier).signUpPressed,
                    child: const Text(Strings.join),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size(100, 54)),
                    onPressed:
                        ref.read(authStateProvider.notifier).signInPressed,
                    child: const Text(Strings.signIn),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
