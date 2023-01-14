import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/report/model/report_type.dart';
part 'report.g.dart';

@JsonSerializable()
class Report {
  @JsonKey(name: FirebaseFieldName.id)
  final String id;
  @JsonKey(name: FirebaseFieldName.uid)
  final String uid;
  @JsonKey(name: FirebaseFieldName.reportId)
  final String reportId;
  @JsonKey(name: FirebaseFieldName.reportType)
  final ReportType type;
  @JsonKey(name: FirebaseFieldName.createdAt)
  final DateTime createdAt;
  @JsonKey(name: FirebaseFieldName.reportReason)
  final String reason;
  Report({
    required this.id,
    required this.uid,
    required this.reportId,
    required this.type,
    required this.createdAt,
    required this.reason,
  });
  factory Report.fromMap(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toMap() => _$ReportToJson(this);
}
