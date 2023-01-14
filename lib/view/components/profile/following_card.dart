import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pixgraphy/state/follow/provider/following_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/profile/user_mini_cards.dart';

import '../model_bottom_sheet/follow_list_bottom_sheet.dart';
import 'column_two_text_card.dart';

class FollowingCard extends ConsumerWidget {
  final String uid;
  const FollowingCard({required this.uid, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserMiniCard(
      onTap: () {
        ref.watch(followingProvider(uid)).maybeWhen(
            data: (followList) => followListBottomSheet(
                  context: context,
                  isFollowers: false,
                  followList: followList,
                ),
            orElse: () => null);
      },
      child: ref.watch(followingProvider(uid)).when(
            data: (followers) => ColumnTwoTextCard(
              title: '${followers.length}',
              subTitle: Strings.following,
            ),
            error: (_, __) => const Icon(
              Icons.error_outline,
            ),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
