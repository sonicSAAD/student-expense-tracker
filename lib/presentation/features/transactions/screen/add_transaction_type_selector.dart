import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';

class AddTransactionTypeSelector extends StatelessWidget {
  const AddTransactionTypeSelector({
    super.key,
    required this.type,
    required this.onChanged,
  });

  final TransactionType type;
  final ValueChanged<TransactionType> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TransactionType>(
      segments: const [
        ButtonSegment(value: TransactionType.expense, label: Text('Expense')),
        ButtonSegment(value: TransactionType.income, label: Text('Income')),
      ],
      selected: {type},
      onSelectionChanged: (s) => onChanged(s.first),
    );
  }
}

class CategoryDropdownField extends StatelessWidget {
  const CategoryDropdownField({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onChanged,
  });

  final List<Category> categories;
  final String? selectedId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedId,
      decoration: const InputDecoration(labelText: 'Category'),
      items: categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
      onChanged: onChanged,
    );
  }
}
