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
);



//Original


// final ThemeData lightTheme = ThemeData(
//   brightness: Brightness.light,
//   colorScheme: const ColorScheme.light(
//     primary: Color(0xFF616E54),
//     onPrimary: Color(0xFFFCFCFC),
//     secondary: Color(0xFF92A56E),
//     onSecondary: Color(0xFFFCFCFC),
//     tertiary: Color(0xFFC2CDA3),
//     onTertiary: Color(0xFF151515),
//     surface: Color(0xFFFCFCFC),
//     surfaceDim: Color(0xFFF2F2F2),
//     surfaceBright: Color(0xFFFFFFFF),
//     onSurface: Color(0xFF151515),
//     onSurfaceVariant: Color(0xFF252525),
//   ),
//   scaffoldBackgroundColor: Color(0xFFF2F2F2),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFFFCFCFC),
//     foregroundColor: Color(0xFF252525),
//   ),
// );

// final ThemeData darkTheme = ThemeData(
//   brightness: Brightness.light,
//   colorScheme: const ColorScheme.light(
//     primary: Color(0xFF616E54),
//     onPrimary: Color(0xFFFCFCFC),
//     secondary: Color(0xFF92A56E),
//     onSecondary: Color(0xFFFCFCFC),
//     tertiary: Color(0xFFC2CDA3),
//     onTertiary: Color(0xFF151515),
//     surface: Color(0xFF191A1F),
//     surfaceDim: Color(0xFF0D0E13),
//     surfaceBright: Color(0xFF262A35),
//     onSurface: Color(0xFFFCFCFC),
//     onSurfaceVariant: Color(0xFFF2F2F2),
//   ),
//   scaffoldBackgroundColor: Color(0xFF0D0E13),
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF191A1F),
//     foregroundColor: Color(0xFFFCFCFC),
//   ),
// );