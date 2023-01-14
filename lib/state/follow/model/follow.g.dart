// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follow _$FollowFromJson(Map<String, dynamic> json) => Follow(
      uid: json['uid'] as String,
      followUid: json['follow_uid'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$FollowToJson(Follow instance) => <String, dynamic>{
      'uid': instance.uid,
      'follow_uid': instance.followUid,
      'created_at': instance.createdAt.toIso8601String(),
    };
