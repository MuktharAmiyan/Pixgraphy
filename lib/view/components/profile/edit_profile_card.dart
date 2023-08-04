import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/user_info/provider/get_user_info.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/profile/column_two_text_card.dart';
import 'package:pixgraphy/view/components/profile/user_mini_cards.dart';

class EditProfileCard extends ConsumerWidget {
  final String uid;
  const EditProfileCard({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserMiniCard(
      onTap: () {
        ref.read(getUserInfoProviderProvider).getUser(uid).then((user) {
          context
              .pushNamed(RouteName.editProfile, extra: user, pathParameters: {
            FirebaseFieldName.uid: uid,
          });
        });
      },
      child: ColumnTwoTextCard(
        icon: Icon(
          Icons.settings_outlined,
          color: Theme.of(context).colorScheme.background,
        ),
        subTitle: Strings.editprofile,
      ),
    );
  }
}
