import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/api_key.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/dialogs/alert_dialog.dart';
import 'package:pixgraphy/view/components/dialogs/sign_out_dialog.dart';
import '../../../state/auth/notifier/auth_state_notifier.dart';
import '../../../state/constant/firebase_const.dart';
import '../profile/profile_circle_avathar.dart';
import '../profile/user_email.dart';
import '../profile/profile_name.dart';
import 'package:http/http.dart' as http;

class ProfileDrawer extends ConsumerWidget {
  final String? uid;
  const ProfileDrawer({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderRadius = Radius.circular(20);
    return Drawer(
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.only(
          bottomRight: borderRadius,
          topRight: borderRadius,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: borderRadius,
                  topRight: borderRadius,
                ),
                color: Theme.of(context).colorScheme.secondaryContainer),
            currentAccountPicture: ProfileCircleAvatar(uid: uid),
            accountName: ProfileName(uid: uid),
            accountEmail: UserEmail(
              uid: uid,
            ),
          ),
          ListTile(
            onTap: () => {
              context.pushNamed(Strings.profile,
                  params: {FirebaseFieldName.uid: uid!}),
              Scaffold.of(context).closeDrawer(),
            },
            leading: const Icon(Icons.person_outline),
            title: Text(
              Strings.profile,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () => context.pushNamed(RouteName.addPost),
            leading: const Icon(Icons.image_outlined),
            title: Text(
              Strings.addPost,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () => context.pushNamed(RouteName.unsplashSearch),
            leading: const Icon(Icons.travel_explore_outlined),
            title: Text(
              Strings.unsplashExplore,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            onTap: () => context.pushNamed(RouteName.settings),
            leading: const Icon(Icons.settings_outlined),
            title: Text(
              Strings.settings,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  const SignOutDialog().show(context).then((res) {
                    log(res.toString());
                    if (res == true) {
                      ref.read(authStateProvider.notifier).signOut();
                    }
                  });
                },
                child: const Text(
                  Strings.signOut,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
