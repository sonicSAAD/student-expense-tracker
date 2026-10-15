import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/add_transaction_form_fields.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/add_transaction_type_selector.dart';

/// Type toggle plus the category and account pickers of the transaction form.
class AddTransactionPickerFields extends StatelessWidget {
  const AddTransactionPickerFields({
    super.key,
    required this.type,
    required this.onTypeChanged,
    required this.categories,
    required this.categoryId,
    required this.onCategoryChanged,
    required this.accounts,
    required this.accountId,
    required this.onAccountChanged,
  });

  final TransactionType type;
  final ValueChanged<TransactionType> onTypeChanged;
  final List<Category> categories;
  final String? categoryId;
  final ValueChanged<String?> onCategoryChanged;
  final List<Account> accounts;
  final String? accountId;
  final ValueChanged<String?> onAccountChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddTransactionTypeSelector(type: type, onChanged: onTypeChanged),
        const SizedBox(height: 16),
        CategoryDropdownField(
          categories: categories,
          selectedId: categoryId,
          onChanged: onCategoryChanged,
        ),
        const SizedBox(height: 16),
        AccountDropdownField(
          accounts: accounts,
          selectedId: accountId,
          onChanged: onAccountChanged,
        ),
      ],
    );
  }
}
