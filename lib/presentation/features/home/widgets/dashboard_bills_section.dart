import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';
import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';

class DashboardBillsSection extends StatelessWidget {
  const DashboardBillsSection({
    super.key,
    required this.bills,
    required this.symbol,
  });

  final List<RecurringBill> bills;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    final upcoming = bills.take(3).toList();

    return Column(
      children: [
        Row(
          children: [
            Text('Upcoming Bills', style: Theme.of(context).textTheme.titleMedium),
            const Spacer(),
            TextButton(
              onPressed: () => context.push(AppRoutes.recurringBills),
              child: const Text('See all'),
            ),
          ],
        ),
        if (upcoming.isEmpty)
          const Card(
            child: ListTile(
              leading: Icon(Icons.event_available),
              title: Text('No upcoming bills'),
            ),
          )
        else
          Card(
            child: Column(
              children: upcoming
                  .map((b) => ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.receipt)),
                        title: Text(b.name),
                        subtitle: Text('Due ${AppDateUtils.formatDate(b.dueDate)}'),
                        trailing: Text(
                          CurrencyFormatter.format(b.amount, symbol),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
