import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/split_expense.dart';
import 'package:student_expense_tracker/domain/usecases/calculators.dart';
import 'package:student_expense_tracker/features/split_expenses/service/split_expense_service.dart';
import 'package:uuid/uuid.dart';

Future<bool?> showSplitDialog(BuildContext context, SplitExpenseService service) {
  final titleCtrl = TextEditingController();
  final totalCtrl = TextEditingController();
  final peopleCtrl = TextEditingController(text: 'Roommate 1, Roommate 2');
  const uuid = Uuid();

  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('New Split Expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
          TextField(
            controller: totalCtrl,
            decoration: const InputDecoration(labelText: 'Total Amount'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: peopleCtrl,
            decoration: const InputDecoration(labelText: 'Names (comma-separated)'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final total = double.tryParse(totalCtrl.text) ?? 0;
            final names = peopleCtrl.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
            if (titleCtrl.text.trim().isEmpty || total <= 0 || names.isEmpty) return;
            final perPerson = SplitCalculator.equalSplit(total, names.length);
            final parts = [
              for (var i = 0; i < names.length; i++)
                SplitParticipant(name: names[i], amount: perPerson[i], hasPaid: false),
            ];
            await service.add(SplitExpense(
              id: uuid.v4(),
              title: titleCtrl.text.trim(),
              totalAmount: total,
              participants: parts,
              date: DateTime.now(),
            ));
            if (ctx.mounted) Navigator.pop(ctx, true);
          },
          child: const Text('Create'),
        ),
      ],
    ),
  );
}
