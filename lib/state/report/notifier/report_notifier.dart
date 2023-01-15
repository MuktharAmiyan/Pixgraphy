import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/report/backend/report_repository.dart';
import 'package:pixgraphy/state/report/model/report.dart';
import 'package:pixgraphy/state/report/model/report_state.dart';
import 'package:pixgraphy/state/report/model/report_type.dart';
import 'package:uuid/uuid.dart';

final reportProvider =
    StateNotifierProvider<ReportNotifier, ReportState>((ref) {
  final reportRepository = ref.read(reportrepositoryProvider);
  return ReportNotifier(reportRepository, ref);
});

class ReportNotifier extends StateNotifier<ReportState> {
  final ReportRepository reportRepository;
  final Ref ref;
  ReportNotifier(this.reportRepository, this.ref)
      : super(const ReportState.initial());
  void onTap(String reason) {
    state = ReportState.resonSelected(reason: reason);
  }

  void report({
    required ReportType reportType,
    required String id,
    required String reason,
  }) async {
    state = const ReportState.loading();
    final reportId = const Uuid().v1();
    final uid = ref.read(userIdProvider);
    if (uid == null) {
      state = const ReportState.failure();
      return;
    }
    final report = Report(
      id: id,
      uid: uid,
      reportId: reportId,
      type: reportType,
      createdAt: DateTime.now(),
      reason: reason,
    );
    final res = await reportRepository.report(report: report);
    if (res) {
      state = const ReportState.success();
    } else {
      state = const ReportState.failure();
    }
  }
}
