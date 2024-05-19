import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../state/auth/notifier/auth_state_notifier.dart';
import '../constants/strings.dart';

class ContinueWithGoogleButton extends ConsumerWidget {
  const ContinueWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        foregroundColor: Theme.of(context).colorScheme.surface,
      ),
      onPressed: ref.read(authStateProvider.notifier).signInWithGoogle,
      icon: const Icon(Icons.flutter_dash),
      label: const Text(
        Strings.continueWithGoogle,
      ),
    );
  }
}
