import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/features/accounts/service/account_service.dart';
import 'package:uuid/uuid.dart';

Future<bool?> showAccountDialog(
  BuildContext context,
  AccountService service, {
  Account? existing,
}) {
  final nameController = TextEditingController(text: existing?.name ?? '');
  final balanceController =
      TextEditingController(text: existing?.balance.toString() ?? '0');
  final icon = existing?.icon ?? 'wallet';
  const uuid = Uuid();

  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(existing != null ? 'Edit Account' : 'Add Account'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: balanceController,
            decoration: const InputDecoration(labelText: 'Balance'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final balance = double.tryParse(balanceController.text) ?? 0;
            if (nameController.text.trim().isEmpty) return;
            final account = Account(
              id: existing?.id ?? uuid.v4(),
              name: nameController.text.trim(),
              icon: icon,
              balance: balance,
            );
            if (existing != null) {
              await service.update(account);
            } else {
              await service.add(account);
            }
            if (ctx.mounted) Navigator.pop(ctx, true);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
