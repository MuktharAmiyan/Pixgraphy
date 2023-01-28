import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/notification/provider/user_notification_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/notification/notification_list_tile.dart';

class UserNotificationView extends ConsumerWidget {
  const UserNotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.notification),
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.refresh(userNotificationProvider),
        child: ref.watch(userNotificationProvider).when(
              data: (userNotification) {
                if (userNotification.isEmpty) {
                  return const Center(
                    child: Text(Strings.noNotification),
                  );
                }
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final notification = userNotification.elementAt(index);
                    return NotificationListTile(notification);
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: userNotification.length,
                );
              },
              error: (_, __) => const Center(
                child: Text(Strings.somethingwentwrong),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
    );
  }
}
