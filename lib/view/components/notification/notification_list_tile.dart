import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/date/extension/date_format.dart';
import 'package:pixgraphy/state/notification/model/notification.dart';
import 'package:pixgraphy/state/notification/model/notification_type.dart';
import 'package:pixgraphy/state/user_info/provider/get_user_info.dart';
import 'package:pixgraphy/view/components/profile/profile_circle_avathar.dart';

class NotificationListTile extends ConsumerWidget {
  final UserNotification userNotification;
  const NotificationListTile(this.userNotification, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserInfoFutureProvider(userNotification.uid)).when(
          data: (user) => ListTile(
            leading: ProfileCircleAvatar(uid: user.uid),
            title: Text(
              "${user.username} ${userNotification.type.toTileString}",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            trailing: Text(userNotification.createdAt.format()),
          ),
          error: (_, __) => const SizedBox(),
          loading: () => const SizedBox(),
        );
  }
}
