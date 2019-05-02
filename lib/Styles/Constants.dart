import 'package:flutter/material.dart';

class Constants {
  /// Font sizes
  static const double fontSizeTitle = 17.0;
  static const double fontSizeAppbarTitle = 20.0;
  static const double fontSizeSubhead = 15.0;
  static const double fontSizeButton = 13.0;

  /// Theme colors
  static const int iThemePrimary = 0xFF333333;
  static const Color ThemePrimary50 = Color(0xFFFFFFFF);
  static const Color ThemePrimary100 = Color(0xFFF8F8F8);
  static const Color ThemePrimary200 = Color(0xFFF0F3F6);
  static const Color ThemePrimary300 = Color(0xFFCCCCCC);
  static const Color ThemePrimary400 = Color(0xFF5A6872);
  static const Color ThemePrimary500 = Color(iThemePrimary);
  static const Color ThemePrimary600 = Color(0xFF292929);
  static const Color ThemePrimary700 = Color(0xFF1F1F1F);
  static const Color ThemePrimary800 = Color(0xFF030202);
  static const Color ThemePrimary900 = Color(0xFF000000);

  static const int iThemeSecondary = 0xFF5B686B;
  static const Color ThemeSecondary50 = Color(0xFFFFFFFF);
  static const Color ThemeSecondary100 = Color(0xFFF0F0F0);
  static const Color ThemeSecondary200 = Color(0xFFD1D3D3);
  static const Color ThemeSecondary300 = Color(0xFF9BA1A3);
  static const Color ThemeSecondary400 = Color(0xFF768083);
  static const Color ThemeSecondary500 = Color(iThemeSecondary);
  static const Color ThemeSecondary600 = Color(0xFF435255);
  static const Color ThemeSecondary700 = Color(0xFF2A373A);
  static const Color ThemeSecondary800 = Color(0xFF2A3639);
  static const Color ThemeSecondary900 = Color(0xFF182A2D);

  static const Color materialBlack = Color(0xFF000000);
  static const Color materialWhite = Color(0xFFFFFFFF);
  static const Color materialGray = Color(0xFF9e9e9e);
  static const Color materialBlue = Color(0xFF2196f3);
  static const Color materialPink = Color(0xFFE91E63);

  static const Color backgroundColor = ThemePrimary50;
  static const Color primarySwatchColor = Color(0xFFF0F0F0);
  static const Color primaryLightColor = Color(0xFF667390);
  static const Color primaryDarkColor = Color(0xFF102138);
  static const Color secondaryColor = Color(0xFFf1f2f3);
  static const Color themeForegroundLight = Color(0xFFFFFFFF);

  /// Material themes
  static const MaterialColor mColorThemePrimary =
      MaterialColor(iThemePrimary, const <int, Color>{
    50: ThemePrimary50,
    100: ThemePrimary100,
    200: ThemePrimary200,
    300: ThemePrimary300,
    400: ThemePrimary400,
    500: ThemePrimary500,
    600: ThemePrimary600,
    700: ThemePrimary700,
    800: ThemePrimary800,
    900: ThemePrimary900,
  });

  static const MaterialColor mColorThemeSecondary =
      const MaterialColor(iThemeSecondary, const <int, Color>{
    50: ThemeSecondary50,
    100: ThemeSecondary100,
    200: ThemeSecondary200,
    300: ThemeSecondary300,
    400: ThemeSecondary400,
    500: ThemeSecondary500,
    600: ThemeSecondary600,
    700: ThemeSecondary700,
    800: ThemeSecondary800,
    900: ThemeSecondary900,
  });
}
