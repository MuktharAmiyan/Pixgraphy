import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import '../../../core/firebase/firebase_firestore.dart';
import '../model/user_info_model.dart';

final userInfoProvider = StreamProvider.family
    .autoDispose<UserInfoModel, String?>((ref, String? uid) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);
  if (uid == null) {
    return const Stream.empty();
  }
  final controller = StreamController<UserInfoModel>();
  final sub = firebaseFirestore
      .collection(FirebaseCollectionName.users)
      .where(FirebaseFieldName.uid, isEqualTo: uid)
      .limit(1)
      .snapshots()
      .listen((docs) {
    final doc = docs.docs.first;
    controller.add(
      UserInfoModel.fromMap(
        doc.data(),
      ),
    );
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
