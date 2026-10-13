import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/presentation/features/budgets/screen/budget_card_item.dart';
import 'package:student_expense_tracker/presentation/features/budgets/screen/budget_overview_header.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/widgets/empty_state_widget.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final categories = ref.watch(categoriesProvider);
    final budgets = ref.watch(currentMonthBudgetsProvider);
    final spending = ref.watch(categorySpendingProvider);
    final monthExpense = ref.watch(monthExpenseProvider);
    final month = AppDateUtils.monthKey(DateTime.now());
    final totalBudget = categories.fold<double>(0, (s, c) => s + c.monthlyBudgetLimit);

    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BudgetOverviewHeader(
            totalBudget: totalBudget,
            monthExpense: monthExpense,
            currencySymbol: settings.currencySymbol,
          ),
          const SizedBox(height: 24),
          if (categories.isEmpty)
            const EmptyStateWidget(
              icon: Icons.pie_chart_outline,
              title: 'No categories',
              subtitle: 'Add categories to manage budgets',
            )
          else
            ...categories.map((cat) {
              final b = budgets.where((x) => x.categoryId == cat.id).firstOrNull;
              return BudgetCardItem(
                cat: cat,
                budget: b,
                spent: b?.spentAmount ?? spending[cat.id] ?? 0,
                limit: b?.limitAmount ?? cat.monthlyBudgetLimit,
                symbol: settings.currencySymbol,
                month: month,
              );
            }),
        ],
      ),
    );
  }
}
