import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/features/accounts/service/transfer_service.dart';

Future<bool?> showTransferDialog(
  BuildContext context,
  List<Account> accounts,
  TransferService transferService,
) {
  if (accounts.length < 2) return Future.value(false);
  String fromId = accounts[0].id;
  String toId = accounts[1].id;
  final amountCtrl = TextEditingController();

  return showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setLocal) => AlertDialog(
        title: const Text('Transfer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: fromId,
              decoration: const InputDecoration(labelText: 'From'),
              items: accounts.map((a) => DropdownMenuItem(value: a.id, child: Text(a.name))).toList(),
              onChanged: (v) => setLocal(() => fromId = v!),
            ),
            DropdownButtonFormField<String>(
              initialValue: toId,
              decoration: const InputDecoration(labelText: 'To'),
              items: accounts.map((a) => DropdownMenuItem(value: a.id, child: Text(a.name))).toList(),
              onChanged: (v) => setLocal(() => toId = v!),
            ),
            TextField(
              controller: amountCtrl,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final amount = double.tryParse(amountCtrl.text);
              if (amount == null || amount <= 0 || fromId == toId) return;
              await transferService.transfer(fromId: fromId, toId: toId, amount: amount);
              if (ctx.mounted) Navigator.pop(ctx, true);
            },
            child: const Text('Transfer'),
          ),
        ],
      ),
    ),
  );
}
