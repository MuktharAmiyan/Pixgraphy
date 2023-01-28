import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/notification/model/notification.dart';

final userNotificationProvider =
    FutureProvider<Iterable<UserNotification>>((ref) async {
  final uid = ref.read(userIdProvider);
  final firebasefirestore = ref.read(firebaseFirestoreProvider);
  if (uid == null) {
    return Future.value([]);
  }
  final completer = Completer<Iterable<UserNotification>>();

  firebasefirestore
      .collection(FirebaseCollectionName.notification)
      .where(FirebaseFieldName.to, isEqualTo: uid)
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .get()
      .then((snapShot) {
    final userNotifications = snapShot.docs.map(
      (doc) => UserNotification.fromMap(
        doc.data(),
      ),
    );
    completer.complete(userNotifications);
  });

  return completer.future;
});
