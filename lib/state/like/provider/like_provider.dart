import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';

import '../../../core/firebase/firebase_firestore.dart';
import '../model/like.dart';

final likeProvider = StreamProvider.family
    .autoDispose<Iterable<Like>, String>((ref, String postId) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);

  final controller = StreamController<Iterable<Like>>();

  final sub = firebaseFirestore
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((snapShot) {
    final likes = snapShot.docs.map(
      (doc) => Like.fromMap(
        doc.data(),
      ),
    );
    controller.add(likes);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
