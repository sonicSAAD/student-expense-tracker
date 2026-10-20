import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:uuid/uuid.dart';

class AccountDropdownField extends StatelessWidget {
  const AccountDropdownField({
    super.key,
    required this.accounts,
    required this.selectedId,
    required this.onChanged,
  });

  final List<Account> accounts;
  final String? selectedId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedId,
      decoration: const InputDecoration(labelText: 'Account'),
      items: accounts.map((a) => DropdownMenuItem(value: a.id, child: Text(a.name))).toList(),
      onChanged: onChanged,
    );
  }
}

Future<void> saveTransactionAction({
  required AppFeatureServices repo,
  required String? id,
  required double amount,
  required TransactionType type,
  required String categoryId,
  required String accountId,
  required String note,
}) async {
  final tx = Transaction(
    id: id ?? const Uuid().v4(),
    amount: amount,
    type: type,
    categoryId: categoryId,
    accountId: accountId,
    note: note,
    date: DateTime.now(),
  );
  final previous = id == null ? null : repo.transactions.findById(id);
  await repo.transactions.add(tx);
  if (previous != null) await repo.transactionBalance.revert(previous);
  await repo.transactionBalance.apply(tx);
  await repo.budgetRecheck.recheckAll();
}
