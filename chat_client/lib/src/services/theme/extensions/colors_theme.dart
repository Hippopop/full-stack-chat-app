import 'package:flutter/material.dart';

extension ColorExtension on BuildContext {
  ColorTheme get color =>
      Theme.of(this).extension<ColorTheme>() ?? ColorTheme();
}

class ColorTheme extends ThemeExtension<ColorTheme> {
  final Color extra;
  final Color theme;
  final Color opposite;

  final Color background;
  final Color primaryBackground;
  final Color secondaryBackground;

  final Color errorState;
  final Color warningState;
  final Color infoState;
  final Color successState;

  final Color text;
  final Color primaryText;
  final Color secondaryText;

  final Color color;
  final Color primary;
  final Color secondary;

  final Color accent;
  final Color primaryAccent;
  final Color secondaryAccent;

  final Color support;
  final Color primarySupport;
  final Color secondarySupport;

  final Color firstBatch;
  final Color primaryFirstBatch;
  final Color secondaryFirstBatch;

  final Color secondBatch;
  final Color primarySecondBatch;
  final Color secondarySecondBatch;

  final Color thirdBatch;
  final Color primaryThirdBatch;
  final Color secondaryThirdBatch;

  ColorTheme({
    this.extra = Colors.blueGrey,
    this.theme = Colors.blueGrey,
    this.opposite = Colors.blueGrey,
    this.background = Colors.blueGrey,
    this.primaryBackground = Colors.blueGrey,
    this.secondaryBackground = Colors.blueGrey,
    this.errorState = Colors.blueGrey,
    this.warningState = Colors.blueGrey,
    this.infoState = Colors.blueGrey,
    this.successState = Colors.blueGrey,
    this.text = Colors.blueGrey,
    this.primaryText = Colors.blueGrey,
    this.secondaryText = Colors.blueGrey,
    this.color = Colors.blueGrey,
    this.primary = Colors.blueGrey,
    this.secondary = Colors.blueGrey,
    this.support = Colors.blueGrey,
    this.primarySupport = Colors.blueGrey,
    this.secondarySupport = Colors.blueGrey,
    this.accent = Colors.blueGrey,
    this.primaryAccent = Colors.blueGrey,
    this.secondaryAccent = Colors.blueGrey,
    this.firstBatch = Colors.blueGrey,
    this.primaryFirstBatch = Colors.blueGrey,
    this.secondaryFirstBatch = Colors.blueGrey,
    this.secondBatch = Colors.blueGrey,
    this.primarySecondBatch = Colors.blueGrey,
    this.secondarySecondBatch = Colors.blueGrey,
    this.thirdBatch = Colors.blueGrey,
    this.primaryThirdBatch = Colors.blueGrey,
    this.secondaryThirdBatch = Colors.blueGrey,
  });

  @override
  ThemeExtension<ColorTheme> copyWith({
    Color? extraColor,
    Color? themeColor,
    Color? oppositeColor,
    Color? mainBackgroundColor,
    Color? primaryBackgroundColor,
    Color? secondaryBackgroundColor,
    Color? errorStateColor,
    Color? warningStateColor,
    Color? infoStateColor,
    Color? successStateColor,
    Color? mainTextColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    Color? mainColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? mainSupportColor,
    Color? primarySupportColor,
    Color? secondarySupportColor,
    Color? mainAccentColor,
    Color? primaryAccentColor,
    Color? secondaryAccentColor,
    Color? mainFirstBatchColor,
    Color? primaryFirstBatchColor,
    Color? secondaryFirstBatchColor,
    Color? mainSecondBatchColor,
    Color? primarySecondBatchColor,
    Color? secondarySecondBatchColor,
    Color? mainThirdBatchColor,
    Color? primaryThirdBatchColor,
    Color? secondaryThirdBatchColor,
  }) {
    return ColorTheme(
      extra: extraColor ?? extra,
      theme: themeColor ?? theme,
      opposite: oppositeColor ?? opposite,
      background: mainBackgroundColor ?? background,
      primaryBackground: primaryBackgroundColor ?? primaryBackground,
      secondaryBackground: secondaryBackgroundColor ?? secondaryBackground,
      errorState: errorStateColor ?? errorState,
      warningState: warningStateColor ?? warningState,
      infoState: infoStateColor ?? infoState,
      successState: successStateColor ?? successState,
      text: mainTextColor ?? text,
      primaryText: primaryTextColor ?? primaryText,
      secondaryText: secondaryTextColor ?? secondaryText,
      color: mainColor ?? color,
      primary: primaryColor ?? primary,
      secondary: secondaryColor ?? secondary,
      support: mainSupportColor ?? support,
      primarySupport: primarySupportColor ?? primarySupport,
      secondarySupport: secondarySupportColor ?? secondarySupport,
      accent: mainAccentColor ?? accent,
      primaryAccent: primaryAccentColor ?? primaryAccent,
      secondaryAccent: secondaryAccentColor ?? secondaryAccent,
      firstBatch: mainFirstBatchColor ?? firstBatch,
      primaryFirstBatch: primaryFirstBatchColor ?? primaryFirstBatch,
      secondaryFirstBatch: secondaryFirstBatchColor ?? secondaryFirstBatch,
      secondBatch: mainSecondBatchColor ?? secondBatch,
      primarySecondBatch: primarySecondBatchColor ?? primarySecondBatch,
      secondarySecondBatch: secondarySecondBatchColor ?? secondarySecondBatch,
      thirdBatch: mainThirdBatchColor ?? thirdBatch,
      primaryThirdBatch: primaryThirdBatchColor ?? primaryThirdBatch,
      secondaryThirdBatch: secondaryThirdBatchColor ?? secondaryThirdBatch,
    );
  }

  @override
  ThemeExtension<ColorTheme> lerp(
    covariant ThemeExtension<ColorTheme>? other,
    double t,
  ) {
    if (other is! ColorTheme) return this;

    return ColorTheme(
      extra: Color.lerp(
        extra,
        other.extra,
        t,
      )!,
      theme: Color.lerp(
        theme,
        other.theme,
        t,
      )!,
      opposite: Color.lerp(
        opposite,
        other.opposite,
        t,
      )!,
      background: Color.lerp(
        background,
        other.background,
        t,
      )!,
      primaryBackground: Color.lerp(
        primaryBackground,
        other.primaryBackground,
        t,
      )!,
      secondaryBackground: Color.lerp(
        secondaryBackground,
        other.secondaryBackground,
        t,
      )!,
      errorState: Color.lerp(
        errorState,
        other.errorState,
        t,
      )!,
      warningState: Color.lerp(
        warningState,
        other.warningState,
        t,
      )!,
      infoState: Color.lerp(
        infoState,
        other.infoState,
        t,
      )!,
      successState: Color.lerp(
        successState,
        other.successState,
        t,
      )!,
      text: Color.lerp(
        text,
        other.text,
        t,
      )!,
      primaryText: Color.lerp(
        primaryText,
        other.primaryText,
        t,
      )!,
      secondaryText: Color.lerp(
        secondaryText,
        other.secondaryText,
        t,
      )!,
      color: Color.lerp(
        color,
        other.color,
        t,
      )!,
      primary: Color.lerp(
        primary,
        other.primary,
        t,
      )!,
      secondary: Color.lerp(
        secondary,
        other.secondary,
        t,
      )!,
      support: Color.lerp(
        support,
        other.support,
        t,
      )!,
      primarySupport: Color.lerp(
        primarySupport,
        other.primarySupport,
        t,
      )!,
      secondarySupport: Color.lerp(
        secondarySupport,
        other.secondarySupport,
        t,
      )!,
      accent: Color.lerp(
        accent,
        other.accent,
        t,
      )!,
      primaryAccent: Color.lerp(
        primaryAccent,
        other.primaryAccent,
        t,
      )!,
      secondaryAccent: Color.lerp(
        secondaryAccent,
        other.secondaryAccent,
        t,
      )!,
      firstBatch: Color.lerp(
        firstBatch,
        other.firstBatch,
        t,
      )!,
      primaryFirstBatch: Color.lerp(
        primaryFirstBatch,
        other.primaryFirstBatch,
        t,
      )!,
      secondaryFirstBatch: Color.lerp(
        secondaryFirstBatch,
        other.secondaryFirstBatch,
        t,
      )!,
      secondBatch: Color.lerp(
        secondBatch,
        other.secondBatch,
        t,
      )!,
      primarySecondBatch: Color.lerp(
        primarySecondBatch,
        other.primarySecondBatch,
        t,
      )!,
      secondarySecondBatch: Color.lerp(
        secondarySecondBatch,
        other.secondarySecondBatch,
        t,
      )!,
      thirdBatch: Color.lerp(
        thirdBatch,
        other.thirdBatch,
        t,
      )!,
      primaryThirdBatch: Color.lerp(
        primaryThirdBatch,
        other.primaryThirdBatch,
        t,
      )!,
      secondaryThirdBatch: Color.lerp(
        secondaryThirdBatch,
        other.secondaryThirdBatch,
        t,
      )!,
    );
  }
}
