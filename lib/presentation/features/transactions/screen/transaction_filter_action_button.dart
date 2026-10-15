import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/transaction_filter_sheet.dart';

/// App bar action that opens the transaction filter sheet.
class TransactionFilterActionButton extends StatelessWidget {
  const TransactionFilterActionButton({
    super.key,
    required this.categories,
    required this.accounts,
    required this.selectedType,
    required this.onSelectType,
    required this.onClearAll,
  });

  final List<Category> categories;
  final List<Account> accounts;
  final TransactionType? selectedType;
  final ValueChanged<TransactionType?> onSelectType;
  final VoidCallback onClearAll;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (_) => TransactionFilterSheet(
          categories: categories,
          accounts: accounts,
          selectedType: selectedType,
          onSelectType: onSelectType,
          onClearAll: onClearAll,
        ),
      ),
    );
  }
}
