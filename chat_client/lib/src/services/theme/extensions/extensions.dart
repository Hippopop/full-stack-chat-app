import 'package:flutter/material.dart';

///[BuildContext] extensions for [Theme] Utilities!
extension ThemeGetter on BuildContext {
  ///[Theme] Root for this [BuildContext]!
  ThemeData get theme => Theme.of(this);

  ///[TextTheme] Root for this [BuildContext]!
  TextTheme get textTheme => theme.textTheme;

  ///Checks if [Brightness] is dark!
  bool get isDarkTheme => theme.brightness == Brightness.dark;
}
