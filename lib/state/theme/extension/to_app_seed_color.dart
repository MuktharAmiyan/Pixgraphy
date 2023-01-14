import 'package:pixgraphy/state/theme/model/app_seed_color.dart';

extension ToAppSeedColor on String {
  AppSeedColor get toAppSeedColor {
    return AppSeedColor.values.byName(this);
  }
}
