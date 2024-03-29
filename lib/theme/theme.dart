import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/main.dart';
import 'package:rta_crm_cv/models/models.dart';

const kThemeModeKey = '__theme_mode__';

void setDarkModeSetting(BuildContext context, ThemeMode themeMode) =>
    MyApp.of(context).setThemeMode(themeMode);

abstract class AppTheme {
  static ThemeMode get themeMode {
    final darkMode = prefs.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.light
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static LightModeTheme lightTheme = LightModeTheme();
  static DarkModeTheme darkTheme = DarkModeTheme();

  static void initConfiguration(Configuration? conf) {
    lightTheme = LightModeTheme(mode: conf?.light);
    darkTheme = DarkModeTheme(mode: conf?.dark);
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? prefs.remove(kThemeModeKey)
      : prefs.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static AppTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkTheme : lightTheme;

  abstract Color primaryColor;
  abstract Color secondaryColor;
  abstract Color tertiaryColor;
  abstract Color alternate;
  abstract Color primaryBackground;
  abstract Color secondaryBackground;
  abstract Color primaryText;
  abstract Color secondaryText;
  abstract Color gris;
  abstract Color managerPrimary;
  abstract Color techSupPrimary;
  abstract Color employeePrimary;
  abstract Color smiPrimary;
  abstract Color odePrimary;
  abstract Color cryPrimary;

  String get title1Family => typography.title1Family;
  TextStyle get title1 => typography.title1;
  String get title2Family => typography.title2Family;
  TextStyle get title2 => typography.title2;
  String get title3Family => typography.title3Family;
  TextStyle get title3 => typography.title3;
  String get subtitle1Family => typography.subtitle1Family;
  TextStyle get subtitle1 => typography.subtitle1;
  String get subtitle2Family => typography.subtitle2Family;
  TextStyle get subtitle2 => typography.subtitle2;
  String get bodyText1Family => typography.bodyText1Family;
  TextStyle get bodyText1 => typography.bodyText1;
  String get bodyText2Family => typography.bodyText2Family;
  TextStyle get bodyText2 => typography.bodyText2;

  TextStyle get tituloPagina => typography.tituloPagina;
  TextStyle get textoSimple => typography.textoSimple;
  TextStyle get textoResaltado => typography.textoResaltado;
  TextStyle get encabezadoTablas => typography.encabezadoTablas;
  TextStyle get encabezadoSubTablas => typography.encabezadoSubTablas;
  TextStyle get contenidoTablas => typography.contenidoTablas;
  TextStyle get hintText => typography.hintText;
  TextStyle get textoError => typography.textoError;
  TextStyle get encabezadoTablasBlack => typography.encabezadoTablasBlack;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends AppTheme {
  @override
  Color primaryColor = const Color(0XFF345694);
  @override
  Color secondaryColor = const Color(0XFFB2333A);
  @override
  Color tertiaryColor = const Color(0xFF102047);
  @override
  Color alternate = const Color(0XFF173938);
  @override
  Color primaryBackground = const Color(0xFFFFFFFF);
  @override
  Color secondaryBackground = const Color(0XFFF7F6F6);
  @override
  Color primaryText = const Color(0xFF000000);
  @override
  Color secondaryText = const Color(0XFFE6E5E6);
  @override
  Color gris = Colors.grey.shade200;
  @override
  Color managerPrimary = const Color(0xFF2EE6DA);
  @override
  Color techSupPrimary = const Color(0xFF5830F2);
  @override
  Color employeePrimary = const Color(0xFFE6C535);
  @override
  Color smiPrimary = const Color.fromRGBO(255, 138, 0, 1);
  @override
  Color odePrimary = const Color(0XFFB2333A);
  @override
  Color cryPrimary = const Color(0XFF345694);

  LightModeTheme({Mode? mode}) {
    if (mode != null) {
      primaryColor = Color(mode.primaryColor);
      secondaryColor = Color(mode.secondaryColor);
      tertiaryColor = Color(mode.tertiaryColor);
      primaryText = Color(mode.primaryText);
      primaryBackground = Color(mode.primaryBackground);
    }
  }
}

class DarkModeTheme extends AppTheme {
  @override
  Color primaryColor = const Color(0XFF345694);
  @override
  Color secondaryColor = const Color(0XFFB2333A);
  @override
  Color tertiaryColor = const Color(0xFF102047);
  @override
  Color alternate = const Color(0XFF173938);
  @override
  Color primaryBackground = const Color(0xFF000000);
  @override
  Color secondaryBackground = const Color(0XFFF7F6F6);
  @override
  Color primaryText = const Color(0xFFFFFFFF);
  @override
  Color secondaryText = const Color(0XFFE6E5E6);
  @override
  Color gris = const Color(0XFF262626);
  @override
  Color managerPrimary = const Color(0xFF2F9992);
  @override
  Color techSupPrimary = const Color(0xFF3128FC);
  @override
  Color employeePrimary = const Color(0xFFE6C535);
  @override
  Color smiPrimary = const Color.fromRGBO(255, 138, 0, 1);
  @override
  Color odePrimary = const Color(0XFFB2333A);
  @override
  Color cryPrimary = const Color(0XFF345694);

  DarkModeTheme({Mode? mode}) {
    if (mode != null) {
      primaryColor = Color(mode.primaryColor);
      secondaryColor = Color(mode.secondaryColor);
      tertiaryColor = Color(mode.tertiaryColor);
      primaryText = Color(mode.primaryText);
      primaryBackground = Color(mode.primaryBackground);
    }
  }
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    required String fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}

abstract class Typography {
  String get title1Family;
  TextStyle get title1;
  String get title2Family;
  TextStyle get title2;
  String get title3Family;
  TextStyle get title3;
  String get subtitle1Family;
  TextStyle get subtitle1;
  String get subtitle2Family;
  TextStyle get subtitle2;
  String get bodyText1Family;
  TextStyle get bodyText1;
  String get bodyText2Family;
  TextStyle get bodyText2;

  TextStyle get tituloPagina;
  TextStyle get textoResaltado;
  TextStyle get textoSimple;
  TextStyle get encabezadoTablas;
  TextStyle get encabezadoSubTablas;
  TextStyle get contenidoTablas;
  TextStyle get hintText;
  TextStyle get textoError;
  TextStyle get encabezadoTablasBlack;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final AppTheme theme;

  @override
  String get title1Family => 'Bicyclette';
  @override
  TextStyle get title1 => TextStyle(
        fontSize: 35,
        fontFamily: 'Bicyclette-Light',
        fontWeight: FontWeight.bold,
        color: theme.primaryColor,
      );
  @override
  String get title2Family => 'Gotham';
  @override
  TextStyle get title2 => TextStyle(
        fontFamily: 'Gotham-Regular',
        color: theme.primaryText,
        fontSize: 25,
      );
  @override
  String get title3Family => 'Gotham';
  @override
  TextStyle get title3 => TextStyle(
        fontSize: 30,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.bold,
        color: theme.primaryText,
      );
  @override
  String get subtitle1Family => 'Gotham';
  @override
  TextStyle get subtitle1 => TextStyle(
        fontSize: 16,
        fontFamily: 'Gotham-Light',
        color: theme.primaryText,
      );

  @override
  String get subtitle2Family => 'Bicyclette';
  @override
  TextStyle get subtitle2 => TextStyle(
        fontFamily: 'Bicyclette-Light',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      );
  @override
  String get bodyText1Family => 'Gotham';
  @override
  TextStyle get bodyText1 => TextStyle(
        fontFamily: 'Gotham-Regular',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      );
  @override
  String get bodyText2Family => 'Gotham';
  @override
  TextStyle get bodyText2 => TextStyle(
        fontFamily: 'Gotham-Light',
        color: theme.primaryText,
        fontWeight: FontWeight.w300,
        fontSize: 18,
      );

  @override
  TextStyle get tituloPagina => TextStyle(
        fontSize: 35,
        fontFamily: 'Gotham-Bold',
        fontWeight: FontWeight.bold,
        color: theme.primaryColor,
      );

  @override
  TextStyle get textoResaltado => TextStyle(
        fontSize: 18,
        fontFamily: 'Gotham-Regular',
        fontWeight: FontWeight.w600,
        color: theme.primaryColor,
      );

  @override
  TextStyle get textoSimple => TextStyle(
        fontSize: 13,
        fontFamily: 'Gotham-Light',
        color: theme.primaryColor,
      );

  @override
  TextStyle get hintText => const TextStyle(
        fontSize: 13,
        fontFamily: 'Gotham-Light',
        color: Colors.grey,
      );

  @override
  TextStyle get encabezadoTablas => TextStyle(
        fontSize: 22,
        fontFamily: 'Gotham-Regular',
        fontWeight: FontWeight.w600,
        color: theme.primaryBackground,
      );

  @override
  TextStyle get encabezadoSubTablas => TextStyle(
      fontSize: 35,
      fontFamily: 'Bicyclette-Bold',
      fontWeight: FontWeight.w800,
      color: theme.primaryColor);

  @override
  TextStyle get contenidoTablas => TextStyle(
        fontSize: 18,
        fontFamily: 'Gotham-Light',
        fontWeight: FontWeight.w400,
        color: theme.primaryText,
      );

  @override
  TextStyle get textoError => const TextStyle(
        fontSize: 13,
        fontFamily: 'Gotham-Light',
        color: Colors.red,
      );
  @override
  TextStyle get encabezadoTablasBlack => const TextStyle(
        fontSize: 22,
        fontFamily: 'Gotham-Light',
        fontWeight: FontWeight.bold,
        color: Colors.black,
      );
}
