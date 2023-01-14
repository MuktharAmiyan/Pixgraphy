import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  const FirebaseCollectionName._();
  static const users = 'Users';
  static const post = 'Post';
  static const likes = 'Likes';
  static const comments = 'Comments';
  static const follow = 'Follow';
  static const image = 'Image';
  static const thumbnail = 'Thumbnail';
}

@immutable
class FirebaseFieldName {
  const FirebaseFieldName._();
  static const uid = 'uid';
  static const name = 'name';
  static const userName = 'user_name';
  static const photoUrl = 'photo_url';
  static const email = 'email';
  static const createdAt = 'created_at';
  static const followUid = 'follow_uid';
  static const postId = 'post_id';
  static const url = 'url';
  static const thumbnailUrl = 'thumbnail_url';
  static const aspectRatio = 'aspect_ratio';
  static const title = 'title';
  static const description = 'description';
  static const shotOn = 'shot_on';
  static const commentId = 'comment_id';
  static const comment = 'comment';
  static const reportId = 'report_id';

  static const id = 'id';
  static const reportReason = 'reason';
  static const reportType = 'report_type';
  static const fcmToken = 'fcm_tokens';
}
