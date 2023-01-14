import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/like/provider/has_liked_provider.dart';
import 'package:pixgraphy/state/like/provider/like_provider.dart';
import 'package:pixgraphy/state/like/provider/like_unlike_provider.dart';
import 'package:pixgraphy/view/components/model_bottom_sheet/like_list_bottom_sheet.dart';
import 'package:pixgraphy/view/components/text/title.dart';

class LikeButton extends ConsumerWidget {
  final String postId;
  const LikeButton({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ref.watch(hasLikedProvider(postId)).when(
              data: (hasLiked) => IconButton(
                onPressed: () => ref.read(likeDislikeProvider(postId)),
                icon: Icon(
                  hasLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: hasLiked
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              error: (_, __) => const Icon(Icons.thumb_up_outlined),
              loading: () => const Icon(Icons.thumb_up_outlined),
            ),
        ref.watch(likeProvider(postId)).when(
              data: (likes) => likes.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () => likesListBottomSheet(
                          context: context,
                          likeList: likes,
                        ),
                        child: TitleWidget(text: '${likes.length}'),
                      ),
                    ),
              error: (_, __) => const SizedBox(),
              loading: () => const SizedBox(),
            )
      ],
    );
  }
}
