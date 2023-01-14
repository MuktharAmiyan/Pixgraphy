import 'package:flutter/material.dart';
import 'package:pixgraphy/view/components/snakbar/snakbar_model.dart';

class ErrorSnackbar extends AppSnackbar {
  const ErrorSnackbar({
    required String errorText,
    required super.context,
  }) : super(
          prefixIcon: const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
          ),
          message: errorText,
        );
}
