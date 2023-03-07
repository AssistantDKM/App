import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/cupertino.dart'
    show CupertinoThemeData, CupertinoTextThemeData;
import 'package:flutter/material.dart';

import '../constants/app_fonts.dart';

ThemeData getDynamicTheme(Brightness brightness) {
  return darkTheme();
}

ThemeData darkTheme() {
  final themeBase = ThemeData.dark();
  final primary = HexColor('8b432b');
  final secondary = HexColor('5AA56D');
  return themeBase.copyWith(
    // useMaterial3: true,
    primaryColor: primary,
    // accentColor: secondary, //DEPRECATED
    colorScheme: themeBase.colorScheme.copyWith(
      primary: primary,
      secondary: secondary,
      secondaryContainer: secondary,
    ),
    textTheme: _buildAppTextTheme(themeBase.textTheme),
    primaryTextTheme: _buildAppTextTheme(themeBase.primaryTextTheme),
    // accentTextTheme: _buildAppTextTheme(base.accentTextTheme, fontFamily), //DEPRECATED
    iconTheme: IconThemeData(color: secondary),
    buttonTheme: ButtonThemeData(
      buttonColor: secondary,
      textTheme: ButtonTextTheme.primary,
    ),
    brightness: Brightness.dark,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    }),
  );
}

TextTheme _buildAppTextTheme(TextTheme themeBase) {
  return themeBase
      .copyWith(
        headlineSmall:
            themeBase.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
        titleLarge: themeBase.titleLarge?.copyWith(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
        bodySmall: themeBase.bodySmall?.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      )
      .apply(fontFamily: defaultFontFamily);
}

CupertinoThemeData toAppleTheme(ThemeData theme) {
  return CupertinoThemeData(
    brightness: theme.brightness,
    primaryColor: theme.primaryColor,
    primaryContrastingColor: theme.colorScheme.secondary,
    scaffoldBackgroundColor: theme.scaffoldBackgroundColor,
    // barBackgroundColor: theme.primaryColor,
    textTheme: toAppleTextTheme(theme),
  );
}

CupertinoTextThemeData toAppleTextTheme(ThemeData theme) {
  return CupertinoTextThemeData(
    // brightness: theme.brightness,
    primaryColor: theme.primaryColor,
    // actionTextStyle: const TextStyle(
    //   color: theme.accentColor,
    //   backgroundColor: theme.backgroundColor,
    // ),
    // textStyle: const TextStyle(
    //   color: theme.accentColor,
    //   backgroundColor: theme.backgroundColor,
    // )
  );
}
