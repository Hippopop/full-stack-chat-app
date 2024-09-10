import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static const themeKey = 'THEME_KEY';
  static const authenticationBoxKey = 'AUTH_TOKEN_STORAGE';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(themeKey);
    await Hive.openBox<String>(authenticationBoxKey);
  }

  Box<String> get themeBox => Hive.box(themeKey);
  Box<String> get authenticationBox => Hive.box(authenticationBoxKey);

  Future<void> dispose() async {
    themeBox.clear();
  }
}
