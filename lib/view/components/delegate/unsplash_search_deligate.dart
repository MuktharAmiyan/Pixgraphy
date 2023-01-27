import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/theme/extension/to_color.dart';
import 'package:pixgraphy/state/unsplash/provider/unspash_search_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/unsplash/unsplash_grid_view.dart';
import '../../../state/theme/theme_provider.dart';

class UnsplashSearchDelegate extends SearchDelegate<Strings> {
  final WidgetRef wRef;
  UnsplashSearchDelegate(this.wRef)
      : super(
          searchFieldLabel: Strings.searchUnPosts,
        );
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox();
    }
    return Consumer(
      builder: (context, ref, child) => ref
          .watch(
            unsplashSearchPostsProvider(
              query.toLowerCase(),
            ),
          )
          .when(
            data: (unPosts) => UnsplashPostGridView(posts: unPosts),
            error: (_, __) => const Center(
              child: Text(
                Strings.somethingwentwrong,
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox();
    }
    return Consumer(
      builder: (context, ref, child) => ref
          .watch(
            unsplashSearchPostsProvider(
              query.toLowerCase(),
            ),
          )
          .when(
            data: (unPosts) => UnsplashPostGridView(posts: unPosts),
            error: (_, __) => const Center(
              child: Text(
                Strings.somethingwentwrong,
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final themeState = wRef.watch(themeProvider);
    return ThemeData(
      useMaterial3: true,
      brightness: themeState.brightness,
      colorScheme: themeState.seedColor.toColor == null
          ? null
          : ColorScheme.fromSeed(
              seedColor: themeState.seedColor.toColor!,
              brightness: themeState.brightness,
            ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }
}
