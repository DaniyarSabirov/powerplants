import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF626C38),
    onPrimary: Color(0xFFF6F6F6),
    secondary: Color(0xFFA6B767),
    onSecondary: Color(0xFFF6F6F6),
    tertiary: Color(0xFFC2CDA3),
    onTertiary: Color(0xFF111111),
    surfaceDim: Color(0xFFF0F0F0),
    surface: Color(0xFFF6F6F6),
    surfaceBright: Color(0xFFFCFCFC),
    surfaceContainerHigh: Color(0xFFFCFCFC),
    surfaceContainerLow: Color(0xFFF0F0F0),
    onSurface: Color(0xFF111111),
    onSurfaceVariant: Color(0xFF2F2F2F),
  ),
  scaffoldBackgroundColor: Color(0xFFF6F6F6),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF6F6F6),
    foregroundColor: Color(0xFF111111),
  ),
  fontFamily: 'Manrope',
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'BigCaslon',
    ),
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w100,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF626C38),
    onPrimary: Color(0xFFF6F6F6),
    secondary: Color(0xFFA6B767),
    onSecondary: Color(0xFFF6F6F6),
    tertiary: Color(0xFFC2CDA3),
    onTertiary: Color(0xFFF6F6F6),
    surfaceDim: Color(0xFF242627),
    surface: Color(0xFF191C1E),
    surfaceBright: Color(0xFF111111),
    surfaceContainerHigh: Color(0xFF242627),
    surfaceContainerLow: Color(0xFF111111),
    onSurface: Color(0xFFEEDDDD),
    onSurfaceVariant: Color(0xFFF2F2F2),
  ),
  scaffoldBackgroundColor: Color(0xFF191C1E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF111111),
    foregroundColor: Color(0xFFF6F6F6),
  ),
  fontFamily: 'Manrope',
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'BigCaslon',
    ),
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
    ),
    labelMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    ),
    displaySmall: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w100,
    ),
  ),
);
