import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/savings_goal.dart';
import 'package:student_expense_tracker/features/savings_goals/service/savings_goal_service.dart';

Future<bool?> showAddMoneyDialog(
  BuildContext context,
  SavingsGoalService service,
  SavingsGoal goal,
) {
  final amountCtrl = TextEditingController();

  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Add Money to ${goal.name}'),
      content: TextField(
        controller: amountCtrl,
        decoration: const InputDecoration(labelText: 'Amount'),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        autofocus: true,
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final amt = double.tryParse(amountCtrl.text);
            if (amt == null || amt <= 0) return;
            await service.addMoney(goal.id, amt);
            if (ctx.mounted) Navigator.pop(ctx, true);
          },
          child: const Text('Add'),
        ),
      ],
    ),
  );
}
