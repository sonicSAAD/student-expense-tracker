import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';

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
              child: _Item(label: 'Income', amount: income, symbol: symbol),
            ),
            Container(width: 1, height: 40, color: Theme.of(context).dividerColor),
            Expanded(
              child: _Item(
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

class _Item extends StatelessWidget {
  const _Item({
    required this.label,
    required this.amount,
    required this.symbol,
    this.isExpense = false,
  });

  final String label;
  final double amount;
  final String symbol;
  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    final color = isExpense ? const Color(0xFFB00020) : const Color(0xFF1A1A1A);
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 6),
        Text(
          CurrencyFormatter.format(amount, symbol),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: color),
        ),
      ],
    );
  }
}
