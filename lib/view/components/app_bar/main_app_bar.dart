import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/auth/provider/user_id_provider.dart';
import '../app_logo/app_logo.dart';
import '../delegate/user_search_delegate.dart';
import '../profile/profile_circle_avathar.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isShow;
  const MainAppBar(this.isShow, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(userIdProvider);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      height: isShow ? 100 : 0,
      child: AppBar(
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
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 120);
}
