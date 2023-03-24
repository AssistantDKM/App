import 'package:flutter/cupertino.dart'
    show CupertinoThemeData, CupertinoTextThemeData;
import 'package:flutter/material.dart';

import '../constants/app_fonts.dart';
import 'color_scheme.dart';

ThemeData getDynamicTheme(Brightness brightness) {
  return darkTheme();
}

ThemeData darkTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
  );

  return base.copyWith(
    brightness: Brightness.dark,
    primaryColor: darkColorScheme.primary,
    textTheme: _buildAppTextTheme(base.textTheme),
    primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme),
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
