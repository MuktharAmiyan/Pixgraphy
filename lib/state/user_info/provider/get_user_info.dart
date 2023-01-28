import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/user_info/model/user_info_model.dart';

final getUserInfoFutureProvider = FutureProvider.family
    .autoDispose<UserInfoModel, String>((ref, String uid) async {
  final firestore = ref.read(firebaseFirestoreProvider);

  return firestore.collection(FirebaseCollectionName.users).doc(uid).get().then(
        (doc) => UserInfoModel.fromMap(
          doc.data()!,
        ),
      );
});

final getUserInfoProviderProvider = Provider<UserInfo>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return UserInfo(firestore);
});

class UserInfo {
  final FirebaseFirestore firestore;
  UserInfo(this.firestore);
  Future<UserInfoModel> getUser(String uid) async {
    return firestore
        .collection(FirebaseCollectionName.users)
        .doc(uid)
        .get()
        .then(
          (doc) => UserInfoModel.fromMap(
            doc.data()!,
          ),
        );
  }
}
