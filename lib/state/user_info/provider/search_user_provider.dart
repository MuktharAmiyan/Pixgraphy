import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';

import '../../../core/firebase/firebase_firestore.dart';
import '../model/user_info_model.dart';

final searchUserProvider =
    StreamProvider.family<Iterable<UserInfoModel>, String>((ref, String query) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);
  final controller = StreamController<Iterable<UserInfoModel>>();

  final sub = firebaseFirestore
      .collection(FirebaseCollectionName.users)
      .where(
        FirebaseFieldName.userName,
        isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
        isLessThan: query.isEmpty
            ? null
            : query.substring(0, query.length - 1) +
                String.fromCharCode(
                  query.codeUnitAt(query.length - 1) + 1,
                ),
        isGreaterThan: query,
      )
      .snapshots()
      .listen((snapShot) {
    final users = snapShot.docs.map(
      (doc) => UserInfoModel.fromMap(
        doc.data(),
      ),
    );
    controller.sink.add(users);
  });
  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });
  return controller.stream;
});
