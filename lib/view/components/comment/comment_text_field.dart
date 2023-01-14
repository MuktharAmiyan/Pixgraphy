import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/profile/profile_circle_avathar.dart';

import '../../../state/comment/notifier/comment_notifier.dart';

class CommentTextField extends ConsumerStatefulWidget {
  final String postId;
  const CommentTextField({
    super.key,
    required this.postId,
  });

  @override
  ConsumerState<CommentTextField> createState() => _CommentTextFieldState();
}

class _CommentTextFieldState extends ConsumerState<CommentTextField> {
  final textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentuser = ref.watch(userIdProvider);
    if (currentuser == null) {
      context.pop();
    }

    ref.listen(commentProvider, (_, state) {
      state.maybeMap(
        success: (_) => context.pop(),
        orElse: () => null,
      );
    });
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfileCircleAvatar(uid: currentuser),
        ),
        Expanded(
          child: TextField(
            controller: textEditingController,
            maxLines: 4,
            minLines: 1,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: Strings.addAComment,
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            if (textEditingController.text.trim().isNotEmpty) {
              ref.read(commentProvider.notifier).addComment(
                    comment: textEditingController.text.trim(),
                    postID: widget.postId,
                  );
            }
          },
          icon: ref.watch(commentProvider).maybeWhen(
                orElse: () => const Icon(Icons.send),
                loading: () => const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ),
                ),
              ),
        )
      ],
    );
  }
}
