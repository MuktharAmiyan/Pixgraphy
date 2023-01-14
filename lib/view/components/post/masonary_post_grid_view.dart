import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/post/model/post.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

import 'network_image_view.dart';

class MasonaryPostGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const MasonaryPostGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(
        child: Text(
          Strings.followuserstoseetheirposts,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }
    return MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      itemCount: posts.length,
      itemBuilder: (context, index) {
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
              child: AspectRatio(
                aspectRatio: post.aspectRatio,
                child: NetworkImageView(
                  post.thumbnailUrl,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
