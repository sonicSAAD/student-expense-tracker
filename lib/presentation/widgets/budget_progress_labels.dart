import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';

/// The "x% used" / "y left" caption line shown under a budget progress bar.
class BudgetProgressLabels extends StatelessWidget {
  const BudgetProgressLabels({
    super.key,
    required this.percentUsed,
    required this.remaining,
    required this.currencySymbol,
    required this.isOver,
  });

  final double percentUsed;
  final double remaining;
  final String currencySymbol;
  final bool isOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${percentUsed.toStringAsFixed(0)}% used',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          '${CurrencyFormatter.format(remaining, currencySymbol)} left',
          style: TextStyle(
            color: isOver ? const Color(0xFFB00020) : null,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
