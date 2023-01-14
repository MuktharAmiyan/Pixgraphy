import 'package:flutter/material.dart';
import 'package:pixgraphy/view/components/comment/comment_on_tap_tile.dart';
import 'package:pixgraphy/view/components/comment/comments_list.dart';

import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/model_bottom_sheet/comment_text_field_bottom_sheet.dart';

void commentsListBottomSheet({
  required BuildContext context,
  required String postId,
}) =>
    Scaffold.of(context).showBottomSheet(
      elevation: 1,
      enableDrag: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      (context) => DraggableScrollableSheet(
        maxChildSize: .8,
        initialChildSize: .6,
        expand: false,
        builder: (context, scrollController) => ListView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Strings.comments,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommentOnTapTile(
                onTap: () => commentTextFieldBottomSheet(
                  context: context,
                  postId: postId,
                ),
              ),
            ),
            CommentsListView(
              postId: postId,
            ),
          ],
        ),
      ),
    );
