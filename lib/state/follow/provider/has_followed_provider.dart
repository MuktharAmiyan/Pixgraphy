import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';

import '../../../core/firebase/firebase_firestore.dart';

final hasFollowedProvider =
    StreamProvider.family.autoDispose<bool, String>((ref, String followUid) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final userId = ref.read(userIdProvider);
  if (userId == null) {
    return Stream<bool>.value(false);
  }
  final controller = StreamController<bool>();
  final sub = firestore
      .collection(FirebaseCollectionName.follow)
      .where(FirebaseFieldName.uid, isEqualTo: userId)
      .where(FirebaseFieldName.followUid, isEqualTo: followUid)
      .snapshots()
      .listen((snapShot) {
    final isFollowed = snapShot.docs.isNotEmpty;
    if (isFollowed) {
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
