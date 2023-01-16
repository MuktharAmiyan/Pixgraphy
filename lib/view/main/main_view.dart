import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/post/provider/feed_provider.dart';
import 'package:pixgraphy/view/components/delegate/user_search_delegate.dart';
import 'package:pixgraphy/view/components/post/masonary_post_grid_view.dart';

import '../../state/auth/provider/user_id_provider.dart';
import '../components/app_logo/app_logo.dart';
import '../components/drawer/profile_drawer.dart';
import '../components/profile/profile_circle_avathar.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userIdProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(builder: (context) {
            return ProfileCircleAvatar(
              uid: uid,
              onTap: () => Scaffold.of(context).openDrawer(),
            );
          }),
        ),
        title: const AppLogo(
          size: 20,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: UserSearchDelegate(ref),
              );
            },
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      drawer: ProfileDrawer(
        uid: uid,
      ),
      body: ref.watch(feedProvider).when(
            data: (posts) => MasonaryPostGridView(
              posts: posts,
            ),
            error: (_, __) => const Center(
              child: Icon(Icons.error_outline),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
