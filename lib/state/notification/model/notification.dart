import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/notification/model/notification_type.dart';
part 'notification.g.dart';

@JsonSerializable()
class UserNotification {
  @JsonKey(name: FirebaseFieldName.uid)
  final String uid;
  @JsonKey(name: FirebaseFieldName.to)
  final String to;
  @JsonKey(name: FirebaseFieldName.notificationType)
  final NotificationType type;
  @JsonKey(name: FirebaseFieldName.id)
  final String id;
  UserNotification({
    required this.uid,
    required this.to,
    required this.type,
    required this.id,
  });
  Map<String, dynamic> toMap() => _$UserNotificationToJson(this);
  factory UserNotification.fromMap(Map<String, dynamic> json) =>
      _$UserNotificationFromJson(json);
}
