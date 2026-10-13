import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';
import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/domain/entities/split_expense.dart';
import 'package:student_expense_tracker/domain/usecases/calculators.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

class SplitExpenseTile extends ConsumerWidget {
  const SplitExpenseTile({super.key, required this.split, required this.symbol});
  final SplitExpense split;
  final String symbol;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(appFeatureProvider);
    final owed = SplitCalculator.totalOwed(
      split.participants.map((p) => p.amount).toList(),
      split.participants.map((p) => p.hasPaid).toList(),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(split.title),
        subtitle: Text(
          '${AppDateUtils.formatDate(split.date)} • ${CurrencyFormatter.format(split.totalAmount, symbol)}',
        ),
        trailing: Chip(
          label: Text(split.isSettled ? 'Settled' : '${CurrencyFormatter.format(owed, symbol)} owed'),
        ),
        children: [
          for (var i = 0; i < split.participants.length; i++)
            CheckboxListTile(
              title: Text(split.participants[i].name),
              subtitle: Text(CurrencyFormatter.format(split.participants[i].amount, symbol)),
              value: split.participants[i].hasPaid,
              onChanged: (v) async {
                await repo.splitExpenses.markParticipantPaid(
                  splitId: split.id,
                  participantIndex: i,
                  paid: v ?? false,
                );
                ref.read(appRefreshProvider.notifier).refresh();
              },
            ),
        ],
      ),
    );
  }
}
