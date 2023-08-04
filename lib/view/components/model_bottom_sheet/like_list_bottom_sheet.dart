import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/like/model/like.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

import '../profile/user_list_tile.dart';

Future<void> likesListBottomSheet(
        {required BuildContext context, required Iterable<Like> likeList}) =>
    showModalBottomSheet<void>(
        elevation: 1,
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
                        Strings.likes,
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
                    ...List.generate(likeList.length, (index) {
                      {
                        final like = likeList.elementAt(index);
                        final uid = like.uid;
                        return UserListTile(
                          uid: uid,
                          onTap: () => {
                            context.pushNamed(
                              RouteName.profile,
                              pathParameters: {
                                FirebaseFieldName.uid: uid,
                              },
                            ),
                          },
                          followButton: false,
                        );
                      }
                    })
                  ],
                )));
