import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/auth_state_notifier.dart';

final userIdProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).maybeMap(
        success: (success) => success.uid,
        orElse: () => null,
      );
});
