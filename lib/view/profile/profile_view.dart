import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/model_bottom_sheet/menu_bottom_sheet.dart';
import 'package:pixgraphy/view/components/profile/profile_menu_list.dart';
import 'package:pixgraphy/view/components/profile/user_card.dart';
import 'package:pixgraphy/view/components/profile/user_name.dart';
import 'package:pixgraphy/view/components/profile/user_posts.dart';

class ProfileView extends ConsumerWidget {
  final String uid;
  const ProfileView({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userIdProvider);
    final isCurrentUser = currentUser == uid;
    return Scaffold(
      appBar: AppBar(
        title: UserName(uid: uid),
        backgroundColor: Colors.transparent,
        actions: [
          if (!isCurrentUser) ...[
            IconButton(
                onPressed: () {
                  showMenuBottomSheet(
                      context: context, child: ProfileMenuList(uid: uid));
                },
                icon: const Icon(CupertinoIcons.ellipsis_vertical))
          ]
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          UserCard(uid: uid),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.photos,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                if (currentUser != null && isCurrentUser)
                  TextButton(
                    onPressed: () => context.pushNamed(RouteName.addPost),
                    child: const Text(Strings.addPost),
                  )
              ],
            ),
          ),
          UserPosts(uid: uid),
        ],
      ),
    );
  }
}
