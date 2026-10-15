import 'package:flutter/material.dart';
import 'package:student_expense_tracker/presentation/features/home/widgets/dashboard_summary_item.dart';

class DashboardSummaryCard extends StatelessWidget {
  const DashboardSummaryCard({
    super.key,
    required this.income,
    required this.expense,
    required this.symbol,
  });

  final double income;
  final double expense;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: DashboardSummaryItem(
                label: 'Income',
                amount: income,
                symbol: symbol,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: Theme.of(context).dividerColor,
            ),
            Expanded(
              child: DashboardSummaryItem(
                label: 'Expense',
                amount: expense,
                symbol: symbol,
                isExpense: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
