import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/notification/backend/notification_repository.dart';
import 'package:pixgraphy/state/notification/model/send_notification.dart';
import 'package:pixgraphy/state/notification/provider/get_user_fcm_token.dart';
import 'package:pixgraphy/state/user_info/model/user_info_model.dart';
import 'package:pixgraphy/state/user_info/provider/get_user_info.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

import '../model/send_follow_notification_request.dart';

final sendFollownotificationProvider = FutureProvider.family
    .autoDispose<void, SendFollowNotificationRequest>(
        (ref, SendFollowNotificationRequest request) async {
  NotificationRepository notificationRepository =
      ref.read(notificationrepositoryProvider);

  List<String?> tokens =
      await ref.read(getUsersFcmTokensProvider).getFcmTokens(request.followUid);

  UserInfoModel user =
      await ref.read(getUserInfoProviderProvider).getUser(request.uid);

  for (var token in tokens) {
    if (token == null) {
      continue;
    }
    notificationRepository.sendNotificationToAUser(
      SendNotification(
        title: Strings.appName,
        body: '${user.username} ${Strings.followedYou}',
        token: token,
      ),
    );
  }
});
