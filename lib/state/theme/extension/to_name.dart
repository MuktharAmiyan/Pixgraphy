import 'package:pixgraphy/state/theme/model/app_seed_color.dart';

extension ToName on AppSeedColor {
  String get toName {
    switch (this) {
      case AppSeedColor.purple:
        return 'Purple';
      case AppSeedColor.indigo:
        return 'Indigo';
      case AppSeedColor.blue:
        return 'Blue';
      case AppSeedColor.teal:
        return 'Teal';
      case AppSeedColor.green:
        return 'Green';
      case AppSeedColor.yellow:
        return 'Yellow';
      case AppSeedColor.orange:
        return 'Orange';
      case AppSeedColor.deepOrange:
        return 'Deep orange';
      case AppSeedColor.pink:
        return 'Pink';
    }
  }
}
