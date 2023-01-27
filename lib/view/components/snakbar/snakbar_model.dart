import 'package:flutter/material.dart';

@immutable
class AppSnackbar {
  final BuildContext context;

  final String message;
  final SnackBarAction? action;

  const AppSnackbar(
      {required this.context, required this.message, this.action});
}

extension Show on AppSnackbar {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> get show =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          action: action,
        ),
      );
}
