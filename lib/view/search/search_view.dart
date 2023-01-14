import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/delegate/user_search_delegate.dart';
import 'package:pixgraphy/view/components/search/search_button.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SearchButton(
              hintText: Strings.searchUser,
              onTap: () {
                showSearch(
                  context: context,
                  delegate: UserSearchDelegate(ref: ref),
                  useRootNavigator: true,
                  query: '',
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
