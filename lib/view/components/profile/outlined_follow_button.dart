import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/follow/provider/follow_unfollow_provider.dart';
import 'package:pixgraphy/state/follow/provider/has_followed_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

class OutlinedFollowButton extends ConsumerWidget {
  final String followId;
  const OutlinedFollowButton({
    required this.followId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(hasFollowedProvider(followId)).when(
          data: (hasFollowed) => OutlinedButton(
            onPressed: () => ref.read(followUnfollowProvider(followId)),
            child: Text(
              hasFollowed ? Strings.unfollow : Strings.follow,
            ),
          ),
          error: (error, _) => const SizedBox(),
          loading: () => const SizedBox(),
        );
  }
}
