import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/user_info/provider/user_info_provider.dart';
import 'package:pixgraphy/view/components/constants/asset_path.dart';

class ProfileCircleAvatar extends ConsumerWidget {
  final String? uid;
  final VoidCallback? onTap;
  final double? radius;
  const ProfileCircleAvatar({
    super.key,
    required this.uid,
    this.onTap,
    this.radius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).canvasColor,
        backgroundImage: ref.watch(userInfoStreamProvider(uid)).when(
              data: (user) {
                if (user.photoUrl == null) {
                  return const AssetImage(AssetPath.defaultProPic);
                }
                return NetworkImage(user.photoUrl!);
              },
              error: (_, __) => null,
              loading: () => null,
            ),
      ),
    );
  }
}
