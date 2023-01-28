import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/notification/model/notification.dart';
import 'package:pixgraphy/state/notification/model/notification_type.dart';
import 'package:pixgraphy/state/user_info/notifier/user_info_notifier.dart';
import 'package:pixgraphy/state/user_info/provider/get_user_info.dart';

class NotificationListTile extends ConsumerWidget {
  final UserNotification userNotification;
  const NotificationListTile(this.userNotification, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserInfoFutureProvider(userNotification.uid)).when(
          data: (user) => ListTile(
            title:
                Text("${user.username} ${userNotification.type.toTileString}"),
          ),
          error: (_, __) => const SizedBox(),
          loading: () => const SizedBox(),
        );
  }
}
