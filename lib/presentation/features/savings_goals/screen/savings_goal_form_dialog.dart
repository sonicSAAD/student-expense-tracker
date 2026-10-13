import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/savings_goal.dart';
import 'package:student_expense_tracker/features/savings_goals/service/savings_goal_service.dart';
import 'package:uuid/uuid.dart';

Future<bool?> showGoalDialog(
  BuildContext context,
  SavingsGoalService service, {
  SavingsGoal? existing,
}) {
  final nameCtrl = TextEditingController(text: existing?.name ?? '');
  final targetCtrl = TextEditingController(text: existing?.targetAmount.toString() ?? '');
  const uuid = Uuid();

  return showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(existing != null ? 'Edit Goal' : 'Create Goal'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Goal Name')),
          TextField(
            controller: targetCtrl,
            decoration: const InputDecoration(labelText: 'Target Amount'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            final target = double.tryParse(targetCtrl.text) ?? 0;
            if (nameCtrl.text.trim().isEmpty || target <= 0) return;
            final goal = SavingsGoal(
              id: existing?.id ?? uuid.v4(),
              name: nameCtrl.text.trim(),
              targetAmount: target,
              currentAmount: existing?.currentAmount ?? 0,
            );
            existing != null ? await service.update(goal) : await service.add(goal);
            if (ctx.mounted) Navigator.pop(ctx, true);
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
