import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';
import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/core/utils/icon_helper.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

class RecurringBillTile extends ConsumerWidget {
  const RecurringBillTile({
    super.key,
    required this.bill,
    required this.symbol,
    required this.onEdit,
  });

  final RecurringBill bill;
  final String symbol;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.read(appFeatureProvider);
    final categories = ref.watch(categoriesProvider);
    final cat = categories.where((c) => c.id == bill.categoryId).firstOrNull;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(child: Icon(iconFromName(cat?.icon ?? 'receipt'))),
        title: Text(bill.name),
        subtitle: Text('Due: ${AppDateUtils.formatDate(bill.dueDate)} (${bill.frequency.name})'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              CurrencyFormatter.format(bill.amount, symbol),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: const Icon(Icons.check_circle_outline),
              onPressed: () async {
                await repo.recurringBillPaid.markAsPaid(bill);
                ref.read(appRefreshProvider.notifier).refresh();
              },
            ),
          ],
        ),
        onTap: onEdit,
        onLongPress: () async {
          await repo.recurringBills.delete(bill.id);
          ref.read(appRefreshProvider.notifier).refresh();
        },
      ),
    );
  }
}
