import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/follow/provider/follow_unfollow_provider.dart';
import 'package:pixgraphy/state/follow/provider/has_followed_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

import 'column_two_text_card.dart';
import 'user_mini_cards.dart';

class FollowButtonCard extends ConsumerWidget {
  final String uid;
  const FollowButtonCard({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserMiniCard(
      onTap: () => ref.read(followUnfollowProvider(uid)),
      child: ref.watch(hasFollowedProvider(uid)).when(
            data: (isFollowed) {
              return ColumnTwoTextCard(
                icon: Icon(
                  isFollowed ? Icons.done : Icons.person_outline,
                  color: Theme.of(context).colorScheme.surface,
                ),
                subTitle: isFollowed ? Strings.unfollow : Strings.follow,
              );
            },
            error: (_, __) => const Icon(Icons.error_outline),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
