import 'package:pixgraphy/view/components/constants/strings.dart';

enum NotificationType {
  like(),
  comment,
  follow,
}

extension TotiltString on NotificationType {
  String get toTileString {
    switch (this) {
      case NotificationType.like:
        return Strings.likedYourPost;
      case NotificationType.comment:
        return Strings.commentedYourPost;
      case NotificationType.follow:
        return Strings.followedYou;
    }
  }
}
