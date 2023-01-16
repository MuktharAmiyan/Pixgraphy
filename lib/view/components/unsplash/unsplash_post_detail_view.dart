import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pixgraphy/state/date/extension/date_format.dart';
import 'package:pixgraphy/state/unsplash/model/unsplash_post.dart';

import 'package:pixgraphy/view/components/post/network_image_view.dart';

import 'package:pixgraphy/view/components/text/subtitle.dart';
import 'package:pixgraphy/view/components/text/title.dart';

class UnsplashPostDetailView extends ConsumerWidget {
  final UnPost post;
  const UnsplashPostDetailView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = post.width ?? 1;
    final height = post.height ?? 1;
    final aspectRatio = width / height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                post.user?.profileImage?.medium ?? ''),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.user?.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                ),
                                SubTitleWidget(
                                  text: post.createdAt?.format() ?? '',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (post.description != null)
                        TitleWidget(text: post.description!),
                      if (post.altDescription != null)
                        SubTitleWidget(text: post.altDescription!),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Hero(
                          tag: post.id ?? '',
                          child: AspectRatio(
                            aspectRatio: aspectRatio,
                            child: NetworkImageView(
                              post.urls?.small ?? '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
