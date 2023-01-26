import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/view/components/text/rich_two_text.dart';

import '../../../state/user_info/provider/user_info_provider.dart';

class CommentUsernameAndComment extends ConsumerWidget {
  final String uid;
  final String comment;
  const CommentUsernameAndComment({
    super.key,
    required this.uid,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RichtwoText(
      text1: ref.watch(userInfoStreamProvider(uid)).when(
          data: (user) => user.username,
          error: (_, __) => '',
          loading: () => ''),
      text1Style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
      text2: comment,
      text2Style: Theme.of(context).textTheme.labelSmall!.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}
