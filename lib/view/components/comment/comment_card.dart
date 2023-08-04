import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/comment/provider/post_comments_provider.dart';
import 'package:pixgraphy/view/components/comment/comment_tile.dart';
import '../../../state/post/model/post.dart';
import '../constants/strings.dart';
import '../model_bottom_sheet/comment_list_bottom_sheet.dart';
import '../model_bottom_sheet/comment_text_field_bottom_sheet.dart';
import '../text/subtitle.dart';
import '../text/title.dart';
import 'comment_on_tap_tile.dart';

class CommentCard extends ConsumerWidget {
  const CommentCard({
    Key? key,
    required this.post,
    required this.userId,
  }) : super(key: key);

  final Post post;
  final String? userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => commentsListBottomSheet(
          context: context,
          postId: post.postId,
        ),
        child: Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const TitleWidget(text: Strings.comments),
                    const SizedBox(width: 8),
                    ref.watch(postCommentProvider(post.postId)).maybeWhen(
                        data: (data) => SubTitleWidget(text: '${data.length}'),
                        orElse: () => const SizedBox())
                  ],
                ),
                if (userId != null) ...[
                  CommentOnTapTile(onTap: () {
                    commentsListBottomSheet(
                      context: context,
                      postId: post.postId,
                    );
                    commentTextFieldBottomSheet(
                      context: context,
                      postId: post.postId,
                    );
                  })
                ],
                ...ref.watch(postCommentProvider(post.postId)).when(
                      data: (comment) => List.generate(
                        comment.length <= 3 ? comment.length : 3,
                        (index) => CommentTile(
                          uid: comment.elementAt(index).uid,
                          comment: comment.elementAt(index),
                          date: comment.elementAt(index).createdAt,
                          isTraling: false,
                        ),
                      ),
                      error: (_, __) => [],
                      loading: () => [],
                    ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: SubTitleWidget(text: Strings.showMore),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
