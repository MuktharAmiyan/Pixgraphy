import 'package:freezed_annotation/freezed_annotation.dart';
part 'report_state.freezed.dart';

@freezed
class ReportState with _$ReportState {
  const factory ReportState.initial() = _Initial;
  const factory ReportState.resonSelected({
    required String reason,
  }) = _ResonSelected;

  const factory ReportState.loading() = _Loading;
  const factory ReportState.success() = _Success;
  const factory ReportState.failure() = _Failure;
}
