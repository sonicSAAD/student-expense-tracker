import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';
import 'package:student_expense_tracker/domain/entities/savings_goal.dart';
import 'package:student_expense_tracker/presentation/features/savings_goals/screen/savings_goal_contribute_dialog.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

class SavingsGoalCard extends ConsumerWidget {
  const SavingsGoalCard({super.key, required this.goal, required this.symbol});
  final SavingsGoal goal;
  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(appFeatureProvider);
    final pct = goal.targetAmount > 0
        ? (goal.currentAmount / goal.targetAmount * 100).clamp(0.0, 100.0)
        : 0.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.savings),
                const SizedBox(width: 10),
                Expanded(child: Text(goal.name, style: Theme.of(context).textTheme.titleSmall)),
                Text('${pct.toStringAsFixed(0)}%', style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: pct / 100,
              minHeight: 6,
              color: const Color(0xFF1A1A1A),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${CurrencyFormatter.format(goal.currentAmount, symbol)} / ${CurrencyFormatter.format(goal.targetAmount, symbol)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add'),
                  onPressed: () async {
                    final ok = await showAddMoneyDialog(context, repo.savingsGoals, goal);
                    if (ok == true) ref.read(appRefreshProvider.notifier).refresh();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
