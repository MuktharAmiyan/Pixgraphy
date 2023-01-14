import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import '../../../core/firebase/firebase_firestore.dart';
import '../model/post.dart';

final userPostsProvider = StreamProvider.family
    .autoDispose<Iterable<Post>, String>((ref, String uid) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);
  final controller = StreamController<Iterable<Post>>();

  final sub = firebaseFirestore
      .collection(FirebaseCollectionName.post)
      .where(FirebaseFieldName.uid, isEqualTo: uid)
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .snapshots()
      .listen((snapShot) {
    final posts = snapShot.docs.map(
      (
        doc,
      ) =>
          Post.fromMap(
        doc.data(),
      ),
    );
    controller.sink.add(posts);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
