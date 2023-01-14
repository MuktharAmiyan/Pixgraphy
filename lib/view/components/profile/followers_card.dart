import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pixgraphy/state/follow/provider/followers_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/model_bottom_sheet/follow_list_bottom_sheet.dart';
import 'package:pixgraphy/view/components/profile/column_two_text_card.dart';

import 'package:pixgraphy/view/components/profile/user_mini_cards.dart';

class FollowersCard extends ConsumerWidget {
  final String uid;
  const FollowersCard({required this.uid, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserMiniCard(
      onTap: () {
        ref.watch(followersProvider(uid)).maybeWhen(
            data: (followList) => followListBottomSheet(
                  context: context,
                  isFollowers: true,
                  followList: followList,
                ),
            orElse: () => null);
      },
      child: ref.watch(followersProvider(uid)).when(
            data: (followers) => ColumnTwoTextCard(
              title: '${followers.length}',
              subTitle: Strings.followers,
            ),
            error: (_, __) => const Icon(
              Icons.error_outline,
            ),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}
