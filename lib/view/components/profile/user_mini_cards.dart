import 'package:flutter/material.dart';

class UserMiniCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const UserMiniCard({super.key, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.all(5),
          color: Theme.of(context).colorScheme.onSurface,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
