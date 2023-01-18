import 'package:flutter/material.dart';

@immutable
class AppSnackbar {
  final BuildContext context;
  final Icon? prefixIcon;
  final String message;

  const AppSnackbar({
    required this.context,
    this.prefixIcon,
    required this.message,
  });
}

extension Show on AppSnackbar {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> get show =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Wrap(
            children: [
              if (prefixIcon != null) ...[prefixIcon!],
              const SizedBox(
                width: 5,
              ),
              Text(
                message,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ],
          ),
        ),
      );
}
