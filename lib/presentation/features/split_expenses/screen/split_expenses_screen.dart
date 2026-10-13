import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/presentation/features/split_expenses/screen/split_expense_form_dialog.dart';
import 'package:student_expense_tracker/presentation/features/split_expenses/screen/split_expense_tile.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/widgets/empty_state_widget.dart';

class SplitExpensesScreen extends ConsumerWidget {
  const SplitExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final splits = ref.watch(splitExpensesProvider);
    final repo = ref.watch(appFeatureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Split Expenses')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ok = await showSplitDialog(context, repo.splitExpenses);
          if (ok == true) ref.read(appRefreshProvider.notifier).refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: splits.isEmpty
          ? EmptyStateWidget(
              icon: Icons.people_outline,
              title: 'No split expenses',
              subtitle: 'Split rent, dinners, and group costs with roommates.',
              actionLabel: 'Add Split',
              onAction: () async {
                final ok = await showSplitDialog(context, repo.splitExpenses);
                if (ok == true) ref.read(appRefreshProvider.notifier).refresh();
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: splits.length,
              itemBuilder: (context, i) => SplitExpenseTile(
                split: splits[i],
                symbol: settings.currencySymbol,
              ),
            ),
    );
  }
}
