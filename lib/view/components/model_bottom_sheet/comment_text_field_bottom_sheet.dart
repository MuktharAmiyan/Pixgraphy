import 'package:flutter/material.dart';
import 'package:pixgraphy/view/components/comment/comment_text_field.dart';

void commentTextFieldBottomSheet({
  required BuildContext context,
  required String postId,
}) =>
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: CommentTextField(
                postId: postId,
              ),
            ));
