import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/domain/entities/budget.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/widgets/budget_progress_bar.dart';

class BudgetCardItem extends ConsumerWidget {
  const BudgetCardItem({
    super.key,
    required this.cat,
    required this.budget,
    required this.spent,
    required this.limit,
    required this.symbol,
    required this.month,
  });

  final Category cat;
  final Budget? budget;
  final double spent;
  final double limit;
  final String symbol;
  final String month;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(appFeatureProvider);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BudgetProgressBar(label: cat.name, spent: spent, limit: limit, currencySymbol: symbol),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: limit > 0 ? limit.toStringAsFixed(0) : '',
              decoration: InputDecoration(labelText: 'Monthly limit', prefixText: symbol),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onFieldSubmitted: (v) async {
                final amount = double.tryParse(v) ?? 0;
                await repo.budgets.setLimit(cat.id, month, amount);
                await repo.categories.update(Category(
                  id: cat.id,
                  name: cat.name,
                  icon: cat.icon,
                  color: cat.color,
                  monthlyBudgetLimit: amount,
                ));
                ref.read(appRefreshProvider.notifier).refresh();
              },
            ),
          ],
        ),
      ),
    );
  }
}
