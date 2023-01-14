// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      postId: json['post_id'] as String,
      uid: json['uid'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      shotOn: json['shot_on'] as String?,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'post_id': instance.postId,
      'uid': instance.uid,
      'url': instance.url,
      'thumbnail_url': instance.thumbnailUrl,
      'aspect_ratio': instance.aspectRatio,
      'title': instance.title,
      'description': instance.description,
      'shot_on': instance.shotOn,
      'created_at': instance.createdAt.toIso8601String(),
    };
