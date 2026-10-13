import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';
import 'package:student_expense_tracker/presentation/widgets/empty_state_widget.dart';
import 'package:student_expense_tracker/presentation/widgets/transaction_tile.dart';

class TransactionListBody extends ConsumerWidget {
  const TransactionListBody({
    super.key, required this.grouped, required this.categories, required this.currencySymbol,
  });

  final Map<String, List<Transaction>> grouped;
  final List<Category> categories;
  final String currencySymbol;

  Future<void> _delete(WidgetRef ref, Transaction t) async {
    final repo = ref.read(appFeatureProvider);
    await repo.transactions.delete(t.id);
    await repo.transactionBalance.revert(t);
    await repo.budgetRecheck.recheckAll();
    ref.read(appRefreshProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (grouped.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.receipt_long, title: 'No transactions found',
        subtitle: 'Try adjusting filters or add a new transaction.',
        actionLabel: 'Add Transaction', onAction: () => context.push(AppRoutes.addTransaction),
      );
    }

    return ListView.builder(
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final label = grouped.keys.elementAt(index);
        final items = grouped[label]!;
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(label, style: Theme.of(context).textTheme.titleSmall),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: items.map((t) {
                final cat = categories.where((c) => c.id == t.categoryId).firstOrNull;
                return TransactionTile(
                  transaction: t,
                  category: cat,
                  currencySymbol: currencySymbol,
                  onTap: () => context.push('${AppRoutes.editTransaction}/${t.id}'),
                  onDelete: () => _delete(ref, t),
                );
              }).toList(),
            ),
          ),
        ]);
      },
    );
  }
}
