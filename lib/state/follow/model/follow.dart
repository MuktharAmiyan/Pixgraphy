import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
part 'follow.g.dart';

@JsonSerializable()
class Follow {
  @JsonKey(name: FirebaseFieldName.uid)
  final String uid;
  @JsonKey(name: FirebaseFieldName.followUid)
  final String followUid;
  @JsonKey(name: FirebaseFieldName.createdAt)
  final DateTime createdAt;

  Follow({
    required this.uid,
    required this.followUid,
    required this.createdAt,
  });

  factory Follow.fromMap(Map<String, dynamic> json) => _$FollowFromJson(json);
  Map<String, dynamic> toMap() => _$FollowToJson(this);
}
