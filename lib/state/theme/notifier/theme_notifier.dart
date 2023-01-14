import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/constant/sharedpreferences_const.dart';
import 'package:pixgraphy/state/theme/extension/to_app_seed_color.dart';
import 'package:pixgraphy/state/theme/extension/to_bool.dart';
import 'package:pixgraphy/state/theme/model/app_seed_color.dart';
import 'package:pixgraphy/state/theme/model/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  late SharedPreferences _preferences;
  ThemeNotifier() : super(ThemeState.unKnown()) {
    _init();
  }
  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
    final themeBrightness =
        _preferences.getBool(PreferencesKey.themeBrightness);
    final seedColor = _preferences.getString(PreferencesKey.seedColor);

    if (themeBrightness != null) {
      //THEME BRIGHTNESS IS NOT NULL
      if (themeBrightness) {
        //BRIGHTNESS IS TRUE WHICH MEANS Brightness.dark
        state = state.copyWith(brightness: Brightness.dark);
      } else {
        //BRIGHTNESS IS FALSE WHICH MEANS Brightness.light
        state = state.copyWith(brightness: Brightness.light);
      }
    }
    if (seedColor != null) {
      //.toAppSeedColor is extension on string to AppSeedColor
      state = state.copyWith(seedColor: seedColor.toAppSeedColor);
    }
  }

  Future<void> changeAppSeedColor(AppSeedColor seedColor) async {
    //.name is used on enum AppseedColor so it is string
    await _preferences.setString(PreferencesKey.seedColor, seedColor.name);
    state = state.copyWith(seedColor: seedColor);
  }

  Future<void> changeBrightness(Brightness brightness) async {
    //.toBool is Extension on enum Brightness
    await _preferences.setBool(
        PreferencesKey.themeBrightness, brightness.toBool);
    state = state.copyWith(brightness: brightness);
  }
}
