import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/search/search_button.dart';

class UnsplashExploreView extends ConsumerWidget {
  const UnsplashExploreView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchButton(
              hintText: Strings.search,
              onTap: () {},
            ),
          ],
        ),
      )),
    );
  }
}
