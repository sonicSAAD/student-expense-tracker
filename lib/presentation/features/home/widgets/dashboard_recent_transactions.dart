import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';
import 'package:student_expense_tracker/presentation/widgets/empty_state_widget.dart';
import 'package:student_expense_tracker/presentation/widgets/transaction_tile.dart';

class DashboardRecentTransactions extends ConsumerWidget {
  const DashboardRecentTransactions({
    super.key,
    required this.transactions,
    required this.categories,
    required this.symbol,
  });

  final List<Transaction> transactions;
  final List<Category> categories;
  final String symbol;

  Future<void> _delete(WidgetRef ref, Transaction t) async {
    final repo = ref.read(appFeatureProvider);
    await repo.transactions.delete(t.id);
    await repo.transactionBalance.revert(t);
    await repo.budgetRecheck.recheckAll();
    ref.read(appRefreshProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recent = transactions.take(6).toList();

    return Column(children: [
      Row(children: [
        Text('Recent Transactions', style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        TextButton(onPressed: () => context.go(AppRoutes.transactions), child: const Text('See all')),
      ]),
      if (recent.isEmpty)
        EmptyStateWidget(
          icon: Icons.receipt_long, title: 'No transactions yet',
          subtitle: 'Add your first expense to start tracking!',
          actionLabel: 'Add Expense', onAction: () => context.push(AppRoutes.addTransaction),
        )
      else
        Card(
          child: Column(
            children: recent.map((t) {
              final cat = categories.where((c) => c.id == t.categoryId).firstOrNull;
              return TransactionTile(
                transaction: t, category: cat, currencySymbol: symbol,
                onTap: () => context.push('${AppRoutes.editTransaction}/${t.id}'),
                onDelete: () => _delete(ref, t),
              );
            }).toList(),
          ),
        ),
    ]);
  }
}
