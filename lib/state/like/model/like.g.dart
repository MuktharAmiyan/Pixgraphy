// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Like _$LikeFromJson(Map<String, dynamic> json) => Like(
      uid: json['uid'] as String,
      postId: json['post_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$LikeToJson(Like instance) => <String, dynamic>{
      'uid': instance.uid,
      'post_id': instance.postId,
      'created_at': instance.createdAt.toIso8601String(),
    };
