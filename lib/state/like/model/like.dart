import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:pixgraphy/state/constant/firebase_const.dart';

part 'like.g.dart';

@JsonSerializable()
class Like {
  @JsonKey(name: FirebaseFieldName.uid)
  final String uid;
  @JsonKey(name: FirebaseFieldName.postId)
  final String postId;
  @JsonKey(name: FirebaseFieldName.createdAt)
  final DateTime createdAt;
  Like({
    required this.uid,
    required this.postId,
    required this.createdAt,
  });

  factory Like.fromMap(Map<String, dynamic> json) => _$LikeFromJson(json);

  Map<String, dynamic> toMap() => _$LikeToJson(this);
}
