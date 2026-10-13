import 'package:flutter/material.dart';

class AppThemeColors {
  static const Color surfaceLight = Color(0xFFFDFDFD);
  static const Color surfaceDark = Color(0xFF141414);
  static const Color backgroundDark = Color(0xFF101010);
  static const Color textPrimaryLight = Color(0xFF1A1A1A);
  static const Color textPrimaryDark = Color(0xFFF2F2F2);
  static const Color accentDark = Color(0xFFCACACA);
  static const Color cardBorderLight = Color(0xFFDADADA);
  static const Color cardBorderDark = Color(0xFF3A3A3A);
  static const Color inputFillDark = Color(0xFF262626);
  static const Color errorLight = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);

  static Color budgetProgressColor(double percentage) {
    if (percentage >= 100) return errorLight;
    if (percentage >= 80) return const Color(0xFF6B6B6B);
    return textPrimaryLight;
  }
}
