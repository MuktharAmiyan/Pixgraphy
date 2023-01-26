import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/theme/extension/to_bool.dart';
import 'package:pixgraphy/state/theme/extension/to_color.dart';
import 'package:pixgraphy/state/user_info/provider/search_user_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/profile/user_list_tile.dart';
import '../../../state/constant/firebase_const.dart';
import '../../../state/theme/theme_provider.dart';

class UserSearchDelegate extends SearchDelegate<Strings> {
  final WidgetRef wRef;
  UserSearchDelegate(this.wRef)
      : super(
          searchFieldLabel: Strings.searchUser,
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
              searchUserProvider(
                query.toLowerCase(),
              ),
            )
            .when(
              data: (users) {
                if (users.isEmpty) {
                  return Center(
                    child: Text(
                      Strings.noUserFound,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, index) {
                    final user = users.elementAt(index);
                    return UserListTile(
                      uid: user.uid,
                      onTap: () {
                        context.pushNamed(
                          RouteName.profile,
                          params: {
                            FirebaseFieldName.uid: user.uid,
                          },
                        );
                      },
                      followButton: false,
                    );
                  },
                );
              },
              error: (_, __) => const Center(
                child: Text(
                  Strings.somethingwentwrong,
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox();
    }
    return Consumer(
        builder: (context, ref, child) => ref
            .watch(
              searchUserProvider(
                query.toLowerCase(),
              ),
            )
            .when(
              data: (users) {
                if (users.isEmpty) {
                  return Center(
                    child: Text(
                      Strings.noUserFound,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, index) {
                    final user = users.elementAt(index);
                    return UserListTile(
                      uid: user.uid,
                      onTap: () {
                        context.pushNamed(
                          RouteName.profile,
                          params: {
                            FirebaseFieldName.uid: user.uid,
                          },
                        );
                      },
                      followButton: false,
                    );
                  },
                );
              },
              error: (_, __) => const Center(
                child: Text(
                  Strings.somethingwentwrong,
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final themeState = wRef.watch(themeProvider);
    return ThemeData(
      useMaterial3: true,
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
