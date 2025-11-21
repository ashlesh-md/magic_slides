import 'package:flutter/material.dart';
import 'package:magic_slides/core/theme/colors.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: _lightColorScheme.onSurface,
      foregroundColor: _lightColorScheme.surface,
      scrolledUnderElevation: 3,
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightColorScheme.primary,
        foregroundColor: _lightColorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _lightColorScheme.secondary,
        foregroundColor: _lightColorScheme.onSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _lightColorScheme.primary,
        side: BorderSide(color: _lightColorScheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: _lightColorScheme.primary),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightColorScheme.surfaceContainerLowest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _lightColorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _lightColorScheme.primary, width: 2),
      ),
      labelStyle: TextStyle(color: _lightColorScheme.onSurfaceVariant),
      hintStyle: TextStyle(color: _lightColorScheme.onSurfaceVariant),
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: _lightColorScheme.surface,
      shadowColor: Colors.black12,
    ),

    iconTheme: IconThemeData(color: _lightColorScheme.onSurface, size: 24),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: _lightColorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: _lightColorScheme.onSurfaceVariant,
      ),
    ),
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: _darkColorScheme.surface,
      foregroundColor: _darkColorScheme.onSurface,
      scrolledUnderElevation: 3,
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkColorScheme.primary,
        foregroundColor: _darkColorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _darkColorScheme.secondary,
        foregroundColor: _darkColorScheme.onSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _darkColorScheme.primary,
        side: BorderSide(color: _darkColorScheme.primary),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkColorScheme.surfaceContainerLowest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkColorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkColorScheme.primary, width: 2),
      ),
      labelStyle: TextStyle(color: _darkColorScheme.onSurfaceVariant),
      hintStyle: TextStyle(color: _darkColorScheme.onSurfaceVariant),
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: _darkColorScheme.surface,
      shadowColor: Colors.black26,
    ),

    iconTheme: IconThemeData(color: _darkColorScheme.onSurface, size: 24),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: _darkColorScheme.onSurface,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: _darkColorScheme.onSurfaceVariant,
      ),
    ),
  );

  static final _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: CustomColors.lightPrimary,
    onPrimary: CustomColors.lightOnPrimary,
    primaryContainer: CustomColors.lightPrimaryContainer,
    onPrimaryContainer: CustomColors.lightOnPrimaryContainer,

    secondary: CustomColors.lightSecondary,
    onSecondary: CustomColors.lightOnSecondary,
    secondaryContainer: CustomColors.lightSecondaryContainer,
    onSecondaryContainer: CustomColors.lightOnSecondaryContainer,

    surface: CustomColors.lightSurface,
    surfaceDim: CustomColors.lightSurfaceDim,
    surfaceBright: CustomColors.lightSurfaceBright,
    onSurface: CustomColors.lightOnSurface,
    onSurfaceVariant: CustomColors.lightOnSurfaceVariant,

    outline: CustomColors.lightOutline,
    outlineVariant: CustomColors.lightOutlineVariant,

    error: CustomColors.lightError,
    onError: CustomColors.lightOnError,
    errorContainer: CustomColors.lightErrorContainer,
    onErrorContainer: CustomColors.lightOnError,

    tertiary: CustomColors.lightSecondary,
    onTertiary: CustomColors.lightOnSecondary,
    tertiaryContainer: CustomColors.lightSecondaryContainer,
    onTertiaryContainer: CustomColors.lightOnSecondaryContainer,

    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: CustomColors.lightSurfaceDim,
    onInverseSurface: CustomColors.lightOnSurface,
    inversePrimary: CustomColors.lightPrimary,

    surfaceContainerHighest: CustomColors.lightSurfaceBright,
    surfaceContainerHigh: CustomColors.lightSurface,
    surfaceContainer: CustomColors.lightSurfaceDim,
    surfaceContainerLow: CustomColors.lightSurfaceDim,
    surfaceContainerLowest: CustomColors.lightSurfaceDim,
  );

  static final _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: CustomColors.darkPrimary,
    onPrimary: CustomColors.darkOnPrimary,
    primaryContainer: CustomColors.darkPrimaryContainer,
    onPrimaryContainer: CustomColors.darkOnPrimaryContainer,

    secondary: CustomColors.darkSecondary,
    onSecondary: CustomColors.darkOnSecondary,
    secondaryContainer: CustomColors.darkSecondaryContainer,
    onSecondaryContainer: CustomColors.darkOnSecondaryContainer,

    surface: CustomColors.darkSurface,
    surfaceDim: CustomColors.darkSurfaceDim,
    surfaceBright: CustomColors.darkSurfaceBright,
    onSurface: CustomColors.darkOnSurface,
    onSurfaceVariant: CustomColors.darkOnSurfaceVariant,

    outline: CustomColors.darkOutline,
    outlineVariant: CustomColors.darkOutlineVariant,

    error: CustomColors.darkError,
    onError: CustomColors.darkOnError,
    errorContainer: CustomColors.darkErrorContainer,
    onErrorContainer: CustomColors.darkOnError,

    tertiary: CustomColors.darkSecondary,
    onTertiary: CustomColors.darkOnSecondary,
    tertiaryContainer: CustomColors.darkSecondaryContainer,
    onTertiaryContainer: CustomColors.darkOnSecondaryContainer,

    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: CustomColors.darkSurfaceBright,
    onInverseSurface: CustomColors.darkOnSurface,
    inversePrimary: CustomColors.darkPrimary,

    surfaceContainerHighest: CustomColors.darkSurfaceBright,
    surfaceContainerHigh: CustomColors.darkSurface,
    surfaceContainer: CustomColors.darkSurfaceDim,
    surfaceContainerLow: CustomColors.darkSurfaceDim,
    surfaceContainerLowest: CustomColors.darkSurfaceDim,
  );
}
