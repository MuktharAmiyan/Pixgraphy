import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constant/firebase_const.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  @JsonKey(name: FirebaseFieldName.uid)
  final String uid;
  @JsonKey(name: FirebaseFieldName.userName)
  final String username;
  @JsonKey(name: FirebaseFieldName.name)
  final String name;
  @JsonKey(name: FirebaseFieldName.email)
  final String email;
  @JsonKey(name: FirebaseFieldName.photoUrl)
  final String? photoUrl;
  @JsonKey(
    name: FirebaseFieldName.fcmToken,
    defaultValue: [],
  )
  final List<String?> fcmToken;
  UserInfoModel({
    required this.uid,
    required this.username,
    required this.name,
    required this.email,
    this.photoUrl,
    this.fcmToken = const [],
  });
  factory UserInfoModel.fromMap(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
  Map<String, dynamic> toMap() => _$UserInfoModelToJson(this);
}
