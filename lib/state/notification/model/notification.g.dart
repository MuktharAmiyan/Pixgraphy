// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    UserNotification(
      uid: json['uid'] as String,
      to: json['to'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['notification_type']),
      id: json['id'] as String,
    );

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'to': instance.to,
      'notification_type': _$NotificationTypeEnumMap[instance.type]!,
      'id': instance.id,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.like: 'like',
  NotificationType.comment: 'comment',
  NotificationType.follow: 'follow',
};
