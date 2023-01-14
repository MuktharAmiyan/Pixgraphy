import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/model/auth_failure.dart';

import 'package:pixgraphy/view/components/app_logo/app_logo.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/google_auth_button/continue_with_google_button.dart';
import 'package:pixgraphy/view/components/liner_progress/appbar_bottom_loading.dart';
import 'package:pixgraphy/view/components/snakbar/error_snakbar.dart';
import 'package:pixgraphy/view/components/snakbar/snakbar_model.dart';

import '../../state/auth/notifier/auth_state_notifier.dart';
import 'sign_up_form.dart';

class SignUpView extends ConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authStateProvider,
      (_, authState) => authState.maybeMap(
        error: (error) => ErrorSnackbar(
          errorText: error.failure.toErrString,
          context: context,
        ).show,
        orElse: () => null,
      ),
    );
    final isLoading = ref.watch(authStateProvider).maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => ref.refresh(authStateProvider),
        ),
        backgroundColor: Colors.transparent,
        bottom: isLoading ? const AppbarBottomLoading() : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const AppLogo(),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  Strings.letsdothis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SignUpForm(),
            const ContinueWithGoogleButton(),
            TextButton(
              onPressed: ref.read(authStateProvider.notifier).signInPressed,
              child: const Text(
                Strings.alreadyhaveanaccount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
