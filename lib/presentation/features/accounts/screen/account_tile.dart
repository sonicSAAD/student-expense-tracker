import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';
import 'package:student_expense_tracker/core/utils/icon_helper.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';

/// Card row for a single account, exposing edit and delete hooks.
class AccountTile extends StatelessWidget {
  const AccountTile({
    super.key,
    required this.account,
    required this.currencySymbol,
    required this.onEdit,
    required this.onLongPress,
  });

  final Account account;
  final String currencySymbol;
  final VoidCallback onEdit;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(child: Icon(iconFromName(account.icon))),
        title: Text(account.name),
        subtitle: Text(
          CurrencyFormatter.format(account.balance, currencySymbol),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: onEdit,
        ),
        onLongPress: onLongPress,
      ),
    );
  }
}
