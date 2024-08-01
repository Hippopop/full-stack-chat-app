import 'package:chat_client/src/services/theme/dark/dark_theme.dart';
import 'package:flutter/material.dart';

import 'app_theme.dart';

final class ThemeConfiguration {
  ThemeConfiguration._();

  static ThemeData get initialTheme => availableThemeList[darkThemeKey]!;
  static Map<String, ThemeData> availableThemeList = {
    darkThemeKey: darkTheme,
    lightThemeKey: lightTheme,
  };
}
