import 'package:flutter/material.dart';
import 'package:student_expense_tracker/presentation/features/budgets/screen/budget_overview_stat.dart';

class BudgetOverviewHeader extends StatelessWidget {
  const BudgetOverviewHeader({
    super.key,
    required this.totalBudget,
    required this.monthExpense,
    required this.currencySymbol,
  });

  final double totalBudget;
  final double monthExpense;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: BudgetOverviewStat(
                label: 'Budgeted',
                value: totalBudget,
                symbol: currencySymbol,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: BudgetOverviewStat(
                label: 'Spent',
                value: monthExpense,
                symbol: currencySymbol,
                color: const Color(0xFFB00020),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
