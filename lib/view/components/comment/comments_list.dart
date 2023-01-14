import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/state/comment/provider/post_comments_provider.dart';
import 'package:pixgraphy/view/components/comment/comment_tile.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/text/title.dart';

import '../../../state/comment/notifier/comment_notifier.dart';

class CommentsListView extends ConsumerWidget {
  final String postId;
  const CommentsListView({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(commentProvider, (_, state) {
      state.maybeMap(
        orElse: () => null,
        deleted: (_) => context.pop(),
      );
    });
    return ref.watch(postCommentProvider(postId)).when(
          data: (commets) {
            if (commets.isEmpty) {
              return const Center(
                child: TitleWidget(text: Strings.noComments),
              );
            }
            return ListView.separated(
              reverse: true,
              shrinkWrap: true,
              itemCount: commets.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final comment = commets.elementAt(index);
                return CommentTile(
                  uid: comment.uid,
                  comment: comment,
                  date: comment.createdAt,
                );
              },
              separatorBuilder: (_, __) => const Divider(),
            );
          },
          error: (_, __) => const SizedBox(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
