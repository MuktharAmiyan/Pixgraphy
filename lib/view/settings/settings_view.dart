import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/view/components/app_logo/app_logo.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.lightbulb_outline),
            title: const Text(Strings.appearance),
            onTap: () => context.pushNamed(RouteName.theme),
          ),
          const AboutListTile(
            icon: Icon(Icons.question_mark),
            applicationName: Strings.appName,
            applicationVersion: '0.1',
            applicationIcon: AppLogo(
              size: 15,
            ),
            aboutBoxChildren: [
              Text(Strings.detailLandingDes),
            ],
          ),
        ],
      ),
    );
  }
}
