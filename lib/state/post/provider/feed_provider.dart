import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/follow/provider/following_provider.dart';
import '../../../core/firebase/firebase_firestore.dart';
import '../model/post.dart';

final feedProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);
  final controller = StreamController<Iterable<Post>>();
  final uid = ref.read(userIdProvider);
  if (uid == null) {
    return Stream.value([]);
  }

  ref.watch(followingProvider(uid)).maybeWhen(
        data: (followList) {
          final sub = firebaseFirestore
              .collection(FirebaseCollectionName.post)
              .orderBy(
                FirebaseFieldName.createdAt,
                descending: true,
              )
              .snapshots()
              .listen((snapShot) {
            final posts = snapShot.docs
                .map(
                  (
                    doc,
                  ) =>
                      Post.fromMap(
                    doc.data(),
                  ),
                )
                .where(
                  (post) => followList.any(
                    (follow) =>
                        (follow.followUid == post.uid) || uid == post.uid,
                  ),
                );
            controller.sink.add(posts);
          });
          ref.onDispose(() {
            sub.cancel();
            controller.close();
          });
        },
        orElse: () {},
      );

  return controller.stream;
});
