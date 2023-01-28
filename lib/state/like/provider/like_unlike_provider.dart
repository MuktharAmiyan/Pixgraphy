import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/like/model/like.dart';
import 'package:pixgraphy/state/notification/backend/notification_repository.dart';
import 'package:pixgraphy/state/notification/model/notification.dart';
import 'package:pixgraphy/state/notification/model/notification_type.dart';
import 'package:pixgraphy/state/notification/model/send_like_notification_request.dart';
import 'package:pixgraphy/state/notification/provider/send_like_notification.dart';
import 'package:pixgraphy/state/post/backend/post_repository.dart';
import '../../../core/firebase/firebase_firestore.dart';

final likeDislikeProvider = FutureProvider.family.autoDispose<bool, String>((
  ref,
  String postId,
) async {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);
  final postRepository = ref.read(postRepositoryProvider);
  final post = await postRepository.getPostWithId(postId);
  final notificationRepository = ref.read(notificationrepositoryProvider);

  final uid = ref.read(userIdProvider);
  if (uid == null) {
    return false;
  }
  final query = firebaseFirestore
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.uid, isEqualTo: uid)
      .where(
        FirebaseFieldName.postId,
        isEqualTo: postId,
      )
      .get();
  //CHECKING FOR USER IS ALREADY LIKED
  final alreadyLiked = await query.then(
    (
      snapShot,
    ) =>
        snapShot.docs.isNotEmpty,
  );

  if (alreadyLiked) {
    // DISLIKE THE POST
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
    // LIKE THE POST
    try {
      final like = Like(
        uid: uid,
        postId: postId,
        createdAt: DateTime.now(),
      );
      await firebaseFirestore.collection(FirebaseCollectionName.likes).add(
            like.toMap(),
          );
      if (post.uid != uid) {
        ref.read(
          sendLikenotificationProvider(
            SendLikeNotificationRequest(
              uid: uid,
              postId: postId,
            ),
          ),
        );
        notificationRepository.saveNitificationFirebase(
          UserNotification(
            uid: uid,
            to: post.uid,
            type: NotificationType.like,
            id: postId,
          ),
        );
      }

      return true;
    } catch (_) {
      return false;
    }
  }
});
