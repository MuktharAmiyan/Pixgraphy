import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import '../constants/strings.dart';
import '../profile/profile_circle_avathar.dart';
import '../text/subtitle.dart';

class CommentOnTapTile extends ConsumerWidget {
  const CommentOnTapTile({Key? key, this.onTap}) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    if (userId == null) {
      return const SizedBox();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProfileCircleAvatar(
          uid: userId,
          radius: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(8).copyWith(right: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Theme.of(context).colorScheme.background,
            ),
            child: const SubTitleWidget(
              text: Strings.addAComment,
            ),
          ),
        ),
      ],
    );
  }
}
