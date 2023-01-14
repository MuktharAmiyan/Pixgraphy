import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../state/auth/notifier/auth_state_notifier.dart';
import '../constants/strings.dart';

class ContinueWithGoogleButton extends ConsumerWidget {
  const ContinueWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        foregroundColor: Theme.of(context).backgroundColor,
      ),
      onPressed: ref.read(authStateProvider.notifier).signInWithGoogle,
      icon: const FaIcon(FontAwesomeIcons.google),
      label: const Text(
        Strings.continueWithGoogle,
      ),
    );
  }
}
