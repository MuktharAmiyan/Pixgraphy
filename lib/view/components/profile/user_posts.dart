import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/post/provider/user_posts_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/post/network_image_view.dart';

class UserPosts extends ConsumerWidget {
  final String uid;
  const UserPosts({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userPostsProvider(uid)).when(
          data: (posts) {
            if (posts.isEmpty) {
              return SizedBox(
                height: 300,
                child: Center(
                  child: Text(
                    Strings.noPostYet,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
              ),
              itemCount: posts.length,
              itemBuilder: (_, index) {
                final post = posts.elementAt(index);
                return Hero(
                  tag: post.postId,
                  child: GestureDetector(
                    onTap: () => context.pushNamed(
                      RouteName.postDetail,
                      extra: post,
                    ),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: NetworkImageView(
                        post.thumbnailUrl,
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (e, __) => Center(
            child: Text('$e'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
