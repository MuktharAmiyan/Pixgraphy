import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import '../../../state/follow/model/follow.dart';
import '../profile/user_list_tile.dart';

Future<void> followListBottomSheet(
        {required BuildContext context,
        required bool isFollowers,
        required Iterable<Follow> followList}) =>
    showModalBottomSheet<void>(
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (context) => DraggableScrollableSheet(
            maxChildSize: .8,
            expand: false,
            builder: (context, scrollController) => ListView(
                  controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        isFollowers ? Strings.followers : Strings.following,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                    ),
                    const Divider(),
                    ...List.generate(followList.length, (index) {
                      final follow = followList.elementAt(index);
                      final uid = isFollowers ? follow.uid : follow.followUid;
                      return UserListTile(
                        uid: uid,
                        onTap: () => {
                          context.pushNamed(
                            RouteName.profile,
                            params: {
                              FirebaseFieldName.uid: uid,
                            },
                          ),
                        },
                      );
                    })
                  ],
                )));
