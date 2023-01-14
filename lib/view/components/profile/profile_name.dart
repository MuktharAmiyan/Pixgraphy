import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/user_info/provider/user_info_provider.dart';

class ProfileName extends ConsumerWidget {
  final String? uid;
  final VoidCallback? onTap;
  final TextStyle? style;
  const ProfileName({
    super.key,
    required this.uid,
    this.onTap,
    this.style,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        ref.watch(userInfoProvider(uid)).when(
            data: (user) => user.name, error: (_, __) => '', loading: () => ''),
        style: style ??
            Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
      ),
    );
  }
}
