// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      uid: json['uid'] as String,
      username: json['user_name'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photo_url'] as String?,
      fcmToken: (json['fcm_tokens'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'user_name': instance.username,
      'name': instance.name,
      'email': instance.email,
      'photo_url': instance.photoUrl,
      'fcm_tokens': instance.fcmToken,
    };
