import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';
import 'package:student_expense_tracker/presentation/widgets/transaction_tile.dart';

/// A single date bucket: its heading plus the card holding its transactions.
class TransactionGroupCard extends StatelessWidget {
  const TransactionGroupCard({
    super.key,
    required this.label,
    required this.items,
    required this.categories,
    required this.currencySymbol,
    required this.onDelete,
  });

  final String label;
  final List<Transaction> items;
  final List<Category> categories;
  final String currencySymbol;
  final ValueChanged<Transaction> onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(label, style: Theme.of(context).textTheme.titleSmall),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: items.map((t) {
              final cat =
                  categories.where((c) => c.id == t.categoryId).firstOrNull;
              return TransactionTile(
                transaction: t,
                category: cat,
                currencySymbol: currencySymbol,
                onTap: () => context.push('${AppRoutes.editTransaction}/${t.id}'),
                onDelete: () => onDelete(t),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
