import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/budget.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/presentation/widgets/budget_progress_bar.dart';

class DashboardBudgetSection extends StatelessWidget {
  const DashboardBudgetSection({
    super.key,
    required this.budgets,
    required this.categories,
    required this.categorySpending,
    required this.symbol,
  });

  final List<Budget> budgets;
  final List<Category> categories;
  final Map<String, double> categorySpending;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    final activeCategories = categories.where((c) => c.monthlyBudgetLimit > 0).take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Budget Progress', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        if (activeCategories.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Set category limits in Budgets to track progress here.'),
            ),
          )
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (final cat in activeCategories)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: BudgetProgressBar(
                        label: cat.name,
                        spent: categorySpending[cat.id] ?? 0,
                        limit: cat.monthlyBudgetLimit,
                        currencySymbol: symbol,
                      ),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
