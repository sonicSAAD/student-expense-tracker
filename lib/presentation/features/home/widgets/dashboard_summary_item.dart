import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';

/// A single labelled amount (income or expense) inside the summary card.
class DashboardSummaryItem extends StatelessWidget {
  const DashboardSummaryItem({
    super.key,
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
    final color =
        isExpense ? const Color(0xFFB00020) : const Color(0xFF1A1A1A);
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 6),
        Text(
          CurrencyFormatter.format(amount, symbol),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: color,
          ),
        ),
      ],
    );
  }
}
