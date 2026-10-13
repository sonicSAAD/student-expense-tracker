import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';

class TransactionFilterSheet extends StatelessWidget {
  const TransactionFilterSheet({
    super.key, required this.categories, required this.accounts,
    required this.selectedType, required this.onSelectType, required this.onClearAll,
  });

  final List<Category> categories;
  final List<Account> accounts;
  final TransactionType? selectedType;
  final ValueChanged<TransactionType?> onSelectType;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filter', style: Theme.of(context).textTheme.titleLarge),
              TextButton(
                onPressed: () { onClearAll(); Navigator.pop(context); },
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                label: const Text('Expense'),
                selected: selectedType == TransactionType.expense,
                onSelected: (v) { onSelectType(v ? TransactionType.expense : null); Navigator.pop(context); },
              ),
              FilterChip(
                label: const Text('Income'),
                selected: selectedType == TransactionType.income,
                onSelected: (v) { onSelectType(v ? TransactionType.income : null); Navigator.pop(context); },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
