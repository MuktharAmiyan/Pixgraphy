import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:pixgraphy/state/constant/firebase_const.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  @JsonKey(name: FirebaseFieldName.commentId)
  final String id;
  @JsonKey(name: FirebaseFieldName.postId)
  final String postId;
  @JsonKey(name: FirebaseFieldName.uid)
  final String uid;
  @JsonKey(name: FirebaseFieldName.comment)
  final String comment;
  @JsonKey(name: FirebaseFieldName.createdAt)
  final DateTime createdAt;
  Comment({
    required this.id,
    required this.postId,
    required this.uid,
    required this.comment,
    required this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toMap() => _$CommentToJson(this);
}
