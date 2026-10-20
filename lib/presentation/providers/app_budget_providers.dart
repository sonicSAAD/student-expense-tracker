import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/domain/entities/budget.dart';
import 'package:student_expense_tracker/features/budgets/service/budget_calc_helper.dart';
import 'package:student_expense_tracker/presentation/providers/app_data_providers.dart';
import 'package:student_expense_tracker/presentation/providers/app_feature_services.dart';

final currentMonthBudgetsProvider = Provider<List<Budget>>((ref) {
  ref.watch(appRefreshProvider);
  return ref
      .watch(appFeatureProvider)
      .budgets
      .getForMonth(AppDateUtils.monthKey(DateTime.now()));
});

// The three metric providers below all read the single cached transaction
// list, so a dashboard rebuild scans Hive once instead of once per metric.
final monthIncomeProvider = Provider<double>((ref) => BudgetCalcHelper.monthIncome(
      ref.watch(transactionsProvider),
      DateTime.now(),
    ));

final monthExpenseProvider = Provider<double>((ref) => BudgetCalcHelper.monthExpense(
      ref.watch(transactionsProvider),
      DateTime.now(),
    ));

final categorySpendingProvider = Provider<Map<String, double>>((ref) =>
    BudgetCalcHelper.spendingForMonth(
      ref.watch(transactionsProvider),
      AppDateUtils.monthKey(DateTime.now()),
    ));

/// Income and expense totals for the last six months, in a single pass.
final monthlySeriesProvider =
    Provider<({List<double> income, List<double> expense})>((ref) =>
        BudgetCalcHelper.monthlySeries(
          ref.watch(transactionsProvider),
          AppDateUtils.lastNMonths(6),
        ));
