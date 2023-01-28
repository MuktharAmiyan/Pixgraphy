import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/follow/model/follow.dart';
import 'package:pixgraphy/state/notification/backend/notification_repository.dart';
import 'package:pixgraphy/state/notification/model/notification.dart';
import 'package:pixgraphy/state/notification/model/notification_type.dart';
import 'package:pixgraphy/state/notification/model/send_follow_notification_request.dart';
import 'package:pixgraphy/state/notification/provider/send_follow_notification.dart';

final followUnfollowProvider = FutureProvider.family.autoDispose<bool, String>((
  ref,
  String followUid,
) async {
  final firestore = ref.read(firebaseFirestoreProvider);
  final uid = ref.read(userIdProvider);
  final notificationRepository = ref.read(notificationrepositoryProvider);
  if (uid == null) {
    return false;
  }
  final query = firestore
      .collection(FirebaseCollectionName.follow)
      .where(FirebaseFieldName.uid, isEqualTo: uid)
      .where(
        FirebaseFieldName.followUid,
        isEqualTo: followUid,
      )
      .get();
  //CHECKING FOR USER IS ALREADY FOLLOWED
  final alreadyfollowed = await query.then(
    (
      snapShot,
    ) =>
        snapShot.docs.isNotEmpty,
  );

  if (alreadyfollowed) {
    //  UNFOLLOW THE USER
    try {
      await query.then((snapShot) async {
        for (var doc in snapShot.docs) {
          await doc.reference.delete();
        }
      });

      return true;
    } catch (_) {
      return false;
    }
  } else {
    // FOLLOW THE USER
    try {
      final follow = Follow(
        uid: uid,
        followUid: followUid,
        createdAt: DateTime.now(),
      );

      await firestore.collection(FirebaseCollectionName.follow).add(
            follow.toMap(),
          );
      ref.read(
        sendFollownotificationProvider(
          SendFollowNotificationRequest(uid, followUid),
        ),
      );
      notificationRepository.saveNitificationFirebase(
        UserNotification(
          uid: uid,
          to: followUid,
          type: NotificationType.follow,
          id: followUid,
          createdAt: DateTime.now(),
        ),
      );

      return true;
    } catch (_) {
      return false;
    }
  }
});
