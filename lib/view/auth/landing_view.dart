import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/view/components/app_logo/app_logo.dart';
import 'package:pixgraphy/view/components/constants/asset_path.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

import '../../state/auth/notifier/auth_state_notifier.dart';

class LandingView extends ConsumerWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (previous, next) {});
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AssetPath.landingBg),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const AppLogo(
                color: Colors.white,
              ),
              Column(
                children: [
                  Text(
                    Strings.smallLandingDes,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    Strings.detailLandingDes,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.grey,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:
                        ref.read(authStateProvider.notifier).signUpPressed,
                    child: const Text(Strings.join),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OutlinedButton(
                    onPressed:
                        ref.read(authStateProvider.notifier).signInPressed,
                    child: const Text(Strings.signIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
