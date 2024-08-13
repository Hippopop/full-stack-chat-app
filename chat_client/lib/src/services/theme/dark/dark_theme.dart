import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/app_bar_theme.dart';
import '../extensions/colors_theme.dart';

const _theme = Colors.white;
const _text = Colors.white;
const _opposite = Colors.black;
const _mainAccent = Color(0xFFFE9901);
const _primaryColor = Color(0xFF00BF6D);
const _primaryAccent = Color(0xFFF5FCF9);

const _secondaryColor = Color(0xFF1D1D35);
const _errorColor = Color(0xFFF03738);
const _warningColor = Color(0xFFF3BB1C);

const darkThemeKey = "#BASE_DARK_THEME";
final darkTheme = ThemeData.dark(useMaterial3: false).copyWith(
  primaryColor: _primaryColor,
  scaffoldBackgroundColor: _secondaryColor,
  appBarTheme: appBarTheme.copyWith(backgroundColor: _secondaryColor),
  iconTheme: const IconThemeData(color: _primaryAccent),
  textTheme: GoogleFonts.interTextTheme().apply(
    decorationColor: _text,
    bodyColor: _primaryAccent,
    displayColor: _text,
  ),
  colorScheme: const ColorScheme.dark().copyWith(
    error: _errorColor,
    primary: _primaryColor,
    secondary: _warningColor,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      foregroundColor: _theme,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _theme,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _secondaryColor,
    selectedItemColor: Colors.white70,
    unselectedItemColor: _primaryAccent.withOpacity(0.32),
    selectedIconTheme: const IconThemeData(color: _primaryColor),
    showUnselectedLabels: true,
  ),
  extensions: {
    ColorTheme(
      text: _text,
      theme: _text,
      opposite: _opposite,
      primary: _primaryColor,
      accent: _mainAccent,
      errorState: _errorColor,
      warningState: _warningColor,
      primaryAccent: _primaryAccent,
      secondaryAccent: _secondaryColor,
    ),
  },
);
