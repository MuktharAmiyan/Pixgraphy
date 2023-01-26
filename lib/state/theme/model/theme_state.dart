import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgraphy/state/theme/model/app_seed_color.dart';
part 'theme_state.freezed.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState({
    required Brightness brightness,
    required AppSeedColor seedColor,
  }) = _ThemeState;

  factory ThemeState.unKnown() => const ThemeState(
        brightness: Brightness.dark,
        seedColor: AppSeedColor.purple,
      );
}
