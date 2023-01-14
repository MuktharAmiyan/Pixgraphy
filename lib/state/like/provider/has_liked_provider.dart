import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';

final hasLikedProvider =
    StreamProvider.family.autoDispose<bool, String>((ref, String postId) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);

  final userId = ref.read(userIdProvider);
  if (userId == null) {
    return Stream<bool>.value(false);
  }
  final controller = StreamController<bool>();
  final sub = firebaseFirestore
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.uid, isEqualTo: userId)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .snapshots()
      .listen((snapShot) {
    final isLiked = snapShot.docs.isNotEmpty;
    if (isLiked) {
      controller.add(true);
    } else {
      controller.add(false);
    }
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
