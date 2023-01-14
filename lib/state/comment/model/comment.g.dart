// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['comment_id'] as String,
      postId: json['post_id'] as String,
      uid: json['uid'] as String,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'comment_id': instance.id,
      'post_id': instance.postId,
      'uid': instance.uid,
      'comment': instance.comment,
      'created_at': instance.createdAt.toIso8601String(),
    };
