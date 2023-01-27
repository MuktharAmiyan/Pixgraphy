import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/model/auth_failure.dart';
import 'package:pixgraphy/view/components/snakbar/snakbar_model.dart';
import '../../state/auth/notifier/auth_state_notifier.dart';
import '../components/app_logo/app_logo.dart';
import '../components/google_auth_button/continue_with_google_button.dart';
import '../components/constants/strings.dart';
import '../components/liner_progress/appbar_bottom_loading.dart';
import 'sign_in_form.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      authStateProvider,
      (_, authState) => authState.maybeMap(
        error: (error) => AppSnackbar(
          message: error.failure.toErrString,
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
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () => ref.refresh(authStateProvider),
        ),
        bottom: isLoading ? const AppbarBottomLoading() : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            Column(
              children: [
                const AppLogo(),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  Strings.welcomeback,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SignInForm(),
            const ContinueWithGoogleButton(),
            TextButton(
                onPressed: ref.read(authStateProvider.notifier).signUpPressed,
                child: const Text(
                  Strings.donthaveanaccount,
                ))
          ],
        ),
      ),
    );
  }
}
