import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void rmvFocus() => FocusManager.instance.primaryFocus?.unfocus();

Future<void> copyClipboard(String data) async {
  try {
    Clipboard.setData(ClipboardData(text: data));
  } catch (e, s) {
    log("#CopyClipboardError", error: e, stackTrace: s);
  }
}

/// Helper function to extract the current method name from the stack trace
String getCurrentMethodName(
    [bool includeClass = true,
    String functionPlaceholder = "functionNameUnresolved?*",
    String classPlaceholder = "UnresolvedClass*"]) {
  final frames = StackTrace.current.toString().split('\n');
  final frame = frames.elementAtOrNull(1);
  if (frame != null) {
    // Extract the method name from the frame. For example, given this input string:
    // #1      LoggerAnalyticsClient.trackAppOpen (package:flutter_ship_app/src/monitoring/logger_analytics_client.dart:28:9)
    // The code will return: LoggerAnalyticsClient.trackAppOpen
    final tokens = frame.replaceAll('', '').split(' ');
    final methodName = tokens.elementAtOrNull(tokens.length - 2);
    if (methodName != null) {
      // if the class name is included, remove it, otherwise return as is
      final methodTokens = methodName.split('.');
      // ignore_for_file:avoid-unsafe-collection-methods
      return methodTokens.length >= 2 && methodTokens[1] != ''
          ? (methodTokens.elementAtOrNull(1) ?? '')
          : methodName;
    }
  }
  return '';
}
