import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/presentation/features/recurring_bills/screen/recurring_bill_form_dialog.dart';
import 'package:student_expense_tracker/presentation/features/recurring_bills/screen/recurring_bill_tile.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/widgets/empty_state_widget.dart';

class RecurringBillsScreen extends ConsumerWidget {
  const RecurringBillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final bills = ref.watch(recurringBillsProvider);
    final categories = ref.watch(categoriesProvider);
    final accounts = ref.watch(accountsProvider);
    final repo = ref.watch(appFeatureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Recurring Bills')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ok = await showBillDialog(context, repo, categories, accounts);
          if (ok == true) ref.read(appRefreshProvider.notifier).refresh();
        },
        child: const Icon(Icons.add),
      ),
      body: bills.isEmpty
          ? const EmptyStateWidget(
              icon: Icons.calendar_today,
              title: 'No recurring bills',
              subtitle: 'Track rent, subscriptions, and utilities.',
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bills.length,
              itemBuilder: (context, i) {
                final bill = bills[i];
                return RecurringBillTile(
                  bill: bill,
                  symbol: settings.currencySymbol,
                  onEdit: () async {
                    final ok = await showBillDialog(
                      context,
                      repo,
                      categories,
                      accounts,
                      existing: bill,
                    );
                    if (ok == true) ref.read(appRefreshProvider.notifier).refresh();
                  },
                );
              },
            ),
    );
  }
}
