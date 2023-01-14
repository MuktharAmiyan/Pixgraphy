// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as String,
      uid: json['uid'] as String,
      reportId: json['report_id'] as String,
      type: $enumDecode(_$ReportTypeEnumMap, json['report_type']),
      createdAt: DateTime.parse(json['created_at'] as String),
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'report_id': instance.reportId,
      'report_type': _$ReportTypeEnumMap[instance.type]!,
      'created_at': instance.createdAt.toIso8601String(),
      'reason': instance.reason,
    };

const _$ReportTypeEnumMap = {
  ReportType.post: 'post',
  ReportType.comment: 'comment',
  ReportType.user: 'user',
};
