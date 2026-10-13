import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/theme/app_theme.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/presentation/features/settings/screen/settings_screen.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/router/app_router.dart';

class StudentExpenseApp extends ConsumerWidget {
  const StudentExpenseApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    ThemeMode themeMode;
    switch (settings.themePreference) {
      case ThemePreference.light:
        themeMode = ThemeMode.light;
      case ThemePreference.dark:
        themeMode = ThemeMode.dark;
      case ThemePreference.system:
        themeMode = ThemeMode.system;
    }

    return MaterialApp.router(
      title: 'Student Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: themeMode,
      routerConfig: goRouterProvider,
      builder: (context, child) {
        return AppLockGate(child: child ?? const SizedBox.shrink());
      },
      scrollBehavior: const ScrollBehavior(),
    );
  }
}
