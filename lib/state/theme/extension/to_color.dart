import 'package:flutter/material.dart';
import 'package:pixgraphy/state/theme/model/app_seed_color.dart';

extension ToColor on AppSeedColor {
  Color get toColor {
    switch (this) {
      case AppSeedColor.red:
        return Colors.red;
      case AppSeedColor.purple:
        return Colors.deepPurple;
      case AppSeedColor.blue:
        return Colors.blue;
      case AppSeedColor.green:
        return Colors.green;
      case AppSeedColor.orange:
        return Colors.orange;
      case AppSeedColor.yellow:
        return Colors.yellow;
    }
  }
}
