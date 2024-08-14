import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static const themeKey = 'THEME_KEY';
  static const tokenBoxKey = 'AUTH_TOKEN_STORAGE';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(themeKey);
    await Hive.openBox<String>(tokenBoxKey);
  }

  Box<String> get themeBox => Hive.box(themeKey);
  Box<String> get tokenBox => Hive.box(tokenBoxKey);

  Future<void> dispose() async {
    themeBox.clear();
  }
}
