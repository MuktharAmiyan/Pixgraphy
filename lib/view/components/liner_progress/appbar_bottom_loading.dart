import 'package:flutter/material.dart';

class AppbarBottomLoading extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarBottomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
      minHeight: 1,
    );
  }

  @override
  Size get preferredSize => const Size(0, 5);
}
