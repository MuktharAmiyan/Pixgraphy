import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/unsplash/provider/unsplah_posts_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/search/search_button.dart';
import 'package:pixgraphy/view/components/unsplash/unsplash_grid_view.dart';

class UnsplashExploreView extends ConsumerWidget {
  const UnsplashExploreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async => ref.refresh(unsplashPostsProvider),
          child: Column(
            children: [
              SearchButton(
                hintText: Strings.search,
                onTap: () {},
              ),
              Expanded(
                child: ref.watch(unsplashPostsProvider).when(
                    data: (unPosts) => UnsplashPostGridView(posts: unPosts),
                    error: (_, __) => const Center(
                          child: Text(Strings.somethingwentwrong),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        )),
              )
            ],
          ),
        ),
      )),
    );
  }
}
