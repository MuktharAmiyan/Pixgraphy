import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/unsplash/model/unsplash_post.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

import '../post/network_image_view.dart';

class UnsplashPostGridView extends StatelessWidget {
  final Iterable<UnPost> posts;
  const UnsplashPostGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(
        child: Text(
          Strings.somethingwentwrong,
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
        final id = post.id ?? '';
        final width = post.width ?? 1;
        final height = post.height ?? 1;
        final aspectRatio = width / height;
        final url = post.urls!.small ?? post.urls!.regular!;
        return Hero(
          tag: id,
          child: GestureDetector(
            onTap: () {
              context.pushNamed(RouteName.unPostDetail, extra: post);
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: NetworkImageView(
                  url,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
