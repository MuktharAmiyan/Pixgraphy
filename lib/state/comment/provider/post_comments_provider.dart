import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';

import '../model/comment.dart';

final postCommentProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, String>((ref, String postId) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final controller = StreamController<Iterable<Comment>>();

  final sub = firestore
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((snapShot) {
    final comments = snapShot.docs.map(
      (doc) => Comment.fromMap(
        doc.data(),
      ),
    );
    controller.add(comments);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });
  return controller.stream;
});
