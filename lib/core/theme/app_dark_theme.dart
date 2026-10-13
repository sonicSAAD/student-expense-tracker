import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/theme/app_theme_colors.dart';

ThemeData buildDarkTheme() {
  const colorScheme = ColorScheme.dark(
    primary: Color(0xFFFFFFFF),
    onPrimary: Color(0xFF1A1A1A),
    secondary: Color(0xFFCACACA),
    onSecondary: Color(0xFF1A1A1A),
    surface: Color(0xFF1C1C1C),
    onSurface: Color(0xFFF2F2F2),
    error: Color(0xFFCF6679),
    onError: Color(0xFF1A1A1A),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppThemeColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Color(0xFF101010),
      foregroundColor: Color(0xFFF2F2F2),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppThemeColors.cardBorderDark),
      ),
      color: const Color(0xFF1C1C1C),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFF2F2F2),
      foregroundColor: Color(0xFF1A1A1A),
      elevation: 2,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppThemeColors.inputFillDark,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppThemeColors.cardBorderDark),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFFFFFFF), width: 2),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
    navigationBarTheme: NavigationBarThemeData(
      elevation: 0,
      height: 64,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      indicatorColor: const Color(0xFFFFFFFF).withValues(alpha: 0.12),
    ),
  );
}
