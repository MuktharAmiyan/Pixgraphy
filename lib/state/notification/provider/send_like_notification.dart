import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/notification/backend/notification_repository.dart';
import 'package:pixgraphy/state/notification/model/send_like_notification_request.dart';
import 'package:pixgraphy/state/notification/model/send_notification.dart';
import 'package:pixgraphy/state/notification/provider/get_user_fcm_token.dart';
import 'package:pixgraphy/state/post/backend/post_repository.dart';
import 'package:pixgraphy/state/post/model/post.dart';
import 'package:pixgraphy/state/user_info/model/user_info_model.dart';
import 'package:pixgraphy/state/user_info/provider/get_user_info.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

final sendLikenotificationProvider =
    FutureProvider.family<void, SendLikeNotificationRequest>((
  ref,
  SendLikeNotificationRequest request,
) async {
  NotificationRepository notificationRepository =
      ref.read(notificationrepositoryProvider);
  Post post =
      await ref.read(postRepositoryProvider).getPostWithId(request.postId);
  List<String?> tokens =
      await ref.read(getUsersFcmTokensProvider).getFcmTokens(post.uid);
  UserInfoModel user =
      await ref.read(getUserInfoProviderProvider).getUser(request.uid);
  for (var token in tokens) {
    if (token == null) return;
    notificationRepository.sendNotificationToAUser(
      SendNotification(
        title: Strings.appName,
        body: '${user.username}  ${Strings.likedYourPost}',
        token: token,
      ),
    );
  }
});
