import 'package:flutter/material.dart';

import '../../../services/theme/theme_config.dart';
import '../source/hive_config.dart';

class ThemeStorage {
  const ThemeStorage();
  HiveConfig get _config => HiveConfig();
  static const String key = '#CURRENT_THEME';

  setNewTheme(String newThemeKey) async {
    await _config.themeBox.put(key, newThemeKey);
  }

  ThemeData currentTheme() {
    final currentThemeKey = _config.themeBox.get(key);
    if (currentThemeKey == null) return ThemeConfiguration.initialTheme;
    return ThemeConfiguration.availableThemeList[currentThemeKey]!;
  }

  Map<String, ThemeData> availableThemeList() =>
      ThemeConfiguration.availableThemeList;
}
