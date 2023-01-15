import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/image_upload/backend/post_upload_repository.dart';
import 'package:pixgraphy/state/user_info/backend/user_info_repository.dart';
import 'package:pixgraphy/state/user_info/model/user_info_state.dart';

final userInfoProvider =
    StateNotifierProvider<UserInfoNotifier, UserInfoState>((ref) {
  final postUploadRepository = ref.read(postUploadRepoProvider);
  final userInfoRepository = ref.read(userInfoRepostoryProvider);
  return UserInfoNotifier(postUploadRepository, userInfoRepository, ref);
});

class UserInfoNotifier extends StateNotifier<UserInfoState> {
  final PostUploadRepository postUploadRepository;
  final UserInfoRepository userInfoRepository;
  final Ref ref;
  UserInfoNotifier(this.postUploadRepository, this.userInfoRepository, this.ref)
      : super(const UserInfoState.initial());
  void editProfile({
    required String? userName,
    required String? name,
    required Uint8List? photo,
  }) async {
    state = const UserInfoState.loading();

    String? photoUrl;

    final uid = ref.read(userIdProvider);

    if (uid == null) {
      state = const UserInfoState.faliure();

      return;
    }

    if (photo != null) {
      final res = await postUploadRepository.putData(
        id: uid,
        reference: FirebaseCollectionName.profilePic,
        data: photo,
      );
      res.fold((l) {
        state = const UserInfoState.faliure();
      }, (r) {
        photoUrl = r;
      });
    }
    final result = await userInfoRepository.editProfile(
        uid: uid, userName: userName, name: name, photoUrl: photoUrl);

    state =
        result ? const UserInfoState.success() : const UserInfoState.faliure();
  }
}
