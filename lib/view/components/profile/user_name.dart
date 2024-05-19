import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/user_info/provider/user_info_provider.dart';

class UserName extends ConsumerWidget {
  final String? uid;
  const UserName({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(userInfoStreamProvider(uid)).when(
          data: (user) => user.username,
          error: (_, __) => '',
          loading: () => ''),
      style: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
    );
  }
}
