import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/state/report/model/report_type.dart';
import 'package:pixgraphy/state/report/notifier/report_notifier.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/liner_progress/appbar_bottom_loading.dart';
import 'package:pixgraphy/view/components/snakbar/snakbar_model.dart';

class ReportView extends ConsumerWidget {
  final ReportType reportType;
  final String id;
  const ReportView({
    super.key,
    required this.reportType,
    required this.id,
  });

  void _report(WidgetRef ref) {
    ref.read(reportProvider).maybeWhen(
        resonSelected: (reason) {
          ref
              .read(reportProvider.notifier)
              .report(reportType: reportType, id: id, reason: reason);
        },
        orElse: () => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref
        .watch(reportProvider)
        .maybeWhen(loading: () => true, orElse: () => false);

    ref.listen(reportProvider, (_, state) {
      state.maybeMap(
          success: (_) {
            context.pop();
          },
          failure: (_) {
            AppSnackbar(message: Strings.somethingwentwrong, context: context)
                .show;
          },
          orElse: () => null);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('${Strings.report} ${reportType.name}'),
        bottom: isLoading ? const AppbarBottomLoading() : null,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: Strings.reportList.length,
          itemBuilder: (context, index) {
            final reportStr = Strings.reportList[index];
            return RadioListTile<String>(
              value: reportStr,
              groupValue: ref.watch(reportProvider).whenOrNull(
                    resonSelected: (reason) => reason,
                  ),
              onChanged: (value) =>
                  ref.read(reportProvider.notifier).onTap(value!),
              title: Text(reportStr),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _report(ref),
        label: const Text(Strings.report),
      ),
    );
  }
}
