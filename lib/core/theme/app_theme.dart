import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/theme/app_dark_theme.dart';
import 'package:student_expense_tracker/core/theme/app_light_theme.dart';

export 'package:student_expense_tracker/core/theme/app_dark_theme.dart';
export 'package:student_expense_tracker/core/theme/app_light_theme.dart';
export 'package:student_expense_tracker/core/theme/app_theme_colors.dart';

class AppTheme {
  static ThemeData lightTheme() => buildLightTheme();
  static ThemeData darkTheme() => buildDarkTheme();
}
