import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/user_info/model/user_info_model.dart';

final getUsersFcmTokensProvider = Provider<GetUsersFcmTokens>((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return GetUsersFcmTokens(firestore);
});

class GetUsersFcmTokens {
  final FirebaseFirestore firestore;
  GetUsersFcmTokens(this.firestore);

  Future<List<String?>> getFcmTokens(String uid) async {
    return firestore
        .collection(FirebaseCollectionName.users)
        .doc(uid)
        .get()
        .then(
      (doc) {
        if (doc.data() == null) {
          return [];
        }
        final user = UserInfoModel.fromMap(doc.data()!);
        return user.fcmToken;
      },
    );
  }
}
