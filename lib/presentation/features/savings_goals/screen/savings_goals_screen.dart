import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/presentation/features/savings_goals/screen/savings_goal_card.dart';
import 'package:student_expense_tracker/presentation/features/savings_goals/screen/savings_goal_form_dialog.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/widgets/empty_state_widget.dart';

class SavingsGoalsScreen extends ConsumerWidget {
  const SavingsGoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final goals = ref.watch(savingsGoalsProvider);
    final repo = ref.watch(appFeatureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Savings Goals')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ok = await showGoalDialog(context, repo.savingsGoals);
          if (ok == true) ref.read(appRefreshProvider.notifier).refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: goals.isEmpty
          ? EmptyStateWidget(
              icon: Icons.savings_outlined,
              title: 'No savings goals yet',
              subtitle: 'Set a target for your next big purchase!',
              actionLabel: 'Create Goal',
              onAction: () async {
                final ok = await showGoalDialog(context, repo.savingsGoals);
                if (ok == true) ref.read(appRefreshProvider.notifier).refresh();
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: goals.length,
              itemBuilder: (context, i) => SavingsGoalCard(
                goal: goals[i],
                symbol: settings.currencySymbol,
              ),
            ),
    );
  }
}
