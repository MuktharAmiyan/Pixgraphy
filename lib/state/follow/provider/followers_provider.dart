import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';

import '../model/follow.dart';

final followersProvider = StreamProvider.family
    .autoDispose<Iterable<Follow>, String>((ref, String followUid) {
  final firestore = ref.read(firebaseFirestoreProvider);
  final conteroller = StreamController<Iterable<Follow>>();
  final sub = firestore
      .collection(FirebaseCollectionName.follow)
      .where(FirebaseFieldName.followUid, isEqualTo: followUid)
      .snapshots()
      .listen((snapShot) {
    final follow = snapShot.docs.map(
      (doc) => Follow.fromMap(
        doc.data(),
      ),
    );
    conteroller.sink.add(follow);
  });

  ref.onDispose(() {
    sub.cancel();
    conteroller.close();
  });

  return conteroller.stream;
});
