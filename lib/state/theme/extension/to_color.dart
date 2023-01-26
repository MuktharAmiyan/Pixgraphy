import 'package:flutter/material.dart';
import 'package:pixgraphy/state/theme/model/app_seed_color.dart';

extension ToColor on AppSeedColor {
  Color? get toColor {
    switch (this) {
      case AppSeedColor.indigo:
        return Colors.indigo;
      case AppSeedColor.blue:
        return Colors.blue;
      case AppSeedColor.teal:
        return Colors.teal;
      case AppSeedColor.green:
        return Colors.green;
      case AppSeedColor.yellow:
        return Colors.yellow;
      case AppSeedColor.orange:
        return Colors.orange;
      case AppSeedColor.deepOrange:
        return Colors.deepOrange;
      case AppSeedColor.pink:
        return Colors.pink;
      default:
        return null;
    }
  }
}
