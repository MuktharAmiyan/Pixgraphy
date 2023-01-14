import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/view/components/profile/outlined_follow_button.dart';
import 'package:pixgraphy/view/components/profile/profile_circle_avathar.dart';
import 'package:pixgraphy/view/components/profile/user_name.dart';

class UserListTile extends ConsumerWidget {
  final String uid;
  final VoidCallback onTap;
  final bool followButton;
  const UserListTile({
    super.key,
    required this.uid,
    required this.onTap,
    this.followButton = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUid = ref.watch(userIdProvider);
    return ListTile(
      leading: ProfileCircleAvatar(uid: uid),
      title: UserName(uid: uid),
      onTap: onTap,
      trailing: (currentUid == uid || currentUid == null || !followButton)
          ? null
          : OutlinedFollowButton(followId: uid),
    );
  }
}
