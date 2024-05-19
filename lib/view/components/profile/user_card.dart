import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/view/components/profile/edit_profile_card.dart';
import 'package:pixgraphy/view/components/profile/follow_button.dart';
import 'package:pixgraphy/view/components/profile/followers_card.dart';
import 'package:pixgraphy/view/components/profile/following_card.dart';
import '../../../state/auth/provider/user_id_provider.dart';
import '../dialogs/profile_pic_dialog.dart';
import 'profile_circle_avathar.dart';
import 'profile_name.dart';

class UserCard extends ConsumerWidget {
  final String uid;
  const UserCard({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userIdProvider);
    final isCurrentUser = currentUser == uid;
    return Card(
      margin: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ProfileCircleAvatar(
              uid: uid,
              radius: 50,
              onTap: () => showProfile(context, uid),
            ),
            ProfileName(uid: uid),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FollowersCard(
                  uid: uid,
                ),
                FollowingCard(
                  uid: uid,
                ),
                if (currentUser != null) ...[
                  isCurrentUser
                      ? EditProfileCard(
                          uid: uid,
                        )
                      : FollowButtonCard(
                          uid: uid,
                        ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
