import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/domain/entities/budget.dart';
import 'package:student_expense_tracker/presentation/providers/app_data_providers.dart';
import 'package:student_expense_tracker/presentation/providers/app_feature_services.dart';

final currentMonthBudgetsProvider = Provider<List<Budget>>((ref) {
  ref.watch(appRefreshProvider);
  final now = DateTime.now();
  final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
  return ref.watch(appFeatureProvider).budgets.getForMonth(month);
});

final monthIncomeProvider = Provider<double>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).budgets.monthIncome(DateTime.now());
});

final monthExpenseProvider = Provider<double>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).budgets.monthExpense(DateTime.now());
});

final categorySpendingProvider = Provider<Map<String, double>>((ref) {
  ref.watch(appRefreshProvider);
  final now = DateTime.now();
  final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';
  return ref.watch(appFeatureProvider).budgets.spendingForMonth(month);
});
