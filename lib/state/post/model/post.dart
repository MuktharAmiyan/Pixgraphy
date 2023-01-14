import 'package:freezed_annotation/freezed_annotation.dart';
import '../../constant/firebase_const.dart';
part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: FirebaseFieldName.postId)
  final String postId;
  @JsonKey(name: FirebaseFieldName.uid)
  final String uid;
  @JsonKey(name: FirebaseFieldName.url)
  final String url;
  @JsonKey(name: FirebaseFieldName.thumbnailUrl)
  final String thumbnailUrl;
  @JsonKey(name: FirebaseFieldName.aspectRatio)
  final double aspectRatio;
  @JsonKey(name: FirebaseFieldName.title)
  final String? title;
  @JsonKey(name: FirebaseFieldName.description)
  final String? description;
  @JsonKey(name: FirebaseFieldName.shotOn)
  final String? shotOn;
  @JsonKey(name: FirebaseFieldName.createdAt)
  final DateTime createdAt;
  Post(
      {required this.postId,
      required this.uid,
      required this.url,
      required this.thumbnailUrl,
      required this.aspectRatio,
      this.title,
      this.description,
      required this.createdAt,
      this.shotOn});

  factory Post.fromMap(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toMap() => _$PostToJson(this);
}
