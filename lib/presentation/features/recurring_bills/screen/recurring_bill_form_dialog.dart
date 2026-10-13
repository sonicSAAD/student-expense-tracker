import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:uuid/uuid.dart';

Future<bool?> showBillDialog(
  BuildContext context, AppFeatureServices repo,
  List<Category> categories, List<Account> accounts, {
  RecurringBill? existing,
}) {
  final nameCtrl = TextEditingController(text: existing?.name ?? '');
  final amtCtrl = TextEditingController(text: existing?.amount.toString() ?? '');
  String? catId = existing?.categoryId ?? categories.firstOrNull?.id;
  String? accId = existing?.accountId ?? accounts.firstOrNull?.id;
  const uuid = Uuid();

  return showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setLocal) => AlertDialog(
        title: Text(existing != null ? 'Edit Bill' : 'Add Bill'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            TextField(
              controller: amtCtrl,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            DropdownButtonFormField<String>(
              initialValue: catId,
              decoration: const InputDecoration(labelText: 'Category'),
              items: categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.name))).toList(),
              onChanged: (v) => setLocal(() => catId = v),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () async {
              final amt = double.tryParse(amtCtrl.text) ?? 0;
              if (nameCtrl.text.trim().isEmpty || catId == null) return;
              final bill = RecurringBill(
                id: existing?.id ?? uuid.v4(), name: nameCtrl.text.trim(),
                amount: amt, categoryId: catId!,
                dueDate: existing?.dueDate ?? DateTime.now(),
                frequency: existing?.frequency ?? BillFrequency.monthly,
                accountId: accId,
              );
              existing != null ? await repo.recurringBills.update(bill) : await repo.recurringBills.add(bill);
              if (ctx.mounted) Navigator.pop(ctx, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
}
