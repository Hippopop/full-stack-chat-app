import 'dart:io';

import 'package:flutter/foundation.dart';

class APIConfig {
  static String get baseURL => (!kIsWeb && Platform.isAndroid)
      ? const String.fromEnvironment("BASE_URL_ANDROID")
      : const String.fromEnvironment("BASE_URL");
  static String refresh = const String.fromEnvironment("REFRESH");
  static String login = const String.fromEnvironment("LOGIN");
  static String register = const String.fromEnvironment("REGISTER");
  static String searchUser = const String.fromEnvironment("SEARCH_USER");
  static String wsUsers = const String.fromEnvironment("WS_USERS");
  static String wsChat = const String.fromEnvironment("WS_CHAT");
  static String requestConnection =
      const String.fromEnvironment("REQUEST_CONNECTION");
  static String updateConnection =
      const String.fromEnvironment("UPDATE_CONNECTION");
}
