import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';

final userInfoRepostoryProvider = Provider<UserInfoRepository>((ref) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);
  return UserInfoRepository(firebaseFirestore);
});

class UserInfoRepository {
  final FirebaseFirestore firebaseFirestore;
  UserInfoRepository(this.firebaseFirestore);
  Future<bool> editProfile(
      {required String uid,
      required String? userName,
      required String? name,
      required String? photoUrl}) async {
    try {
      if (userName != null) {
        await firebaseFirestore
            .collection(FirebaseCollectionName.users)
            .doc(uid)
            .update({FirebaseFieldName.userName: userName});
      }
      if (name != null) {
        await firebaseFirestore
            .collection(FirebaseCollectionName.users)
            .doc(uid)
            .update({FirebaseFieldName.name: name});
      }
      if (photoUrl != null) {
        await firebaseFirestore
            .collection(FirebaseCollectionName.users)
            .doc(uid)
            .update({FirebaseFieldName.photoUrl: photoUrl});
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
