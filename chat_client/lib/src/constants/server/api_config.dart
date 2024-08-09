class APIConfig {
  static String get baseURL => const String.fromEnvironment("BASE_URL");
  static String get refresh => const String.fromEnvironment("REFRESH");
  static String get login => const String.fromEnvironment("LOGIN");
  static String get register => const String.fromEnvironment("REGISTER");
}
