import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';

class BudgetProgressBar extends StatelessWidget {
  const BudgetProgressBar({
    super.key,
    required this.label,
    required this.spent,
    required this.limit,
    required this.currencySymbol,
  });

  final String label;
  final double spent;
  final double limit;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final pct = limit > 0 ? (spent / limit) * 100 : 0.0;
    final remaining = limit - spent;
    final isOver = pct >= 100;
    final color = isOver
        ? const Color(0xFFB00020)
        : (pct >= 80 ? const Color(0xFF757575) : const Color(0xFF1A1A1A));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleSmall),
            Text(
              CurrencyFormatter.format(spent, currencySymbol),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: limit > 0 ? (spent / limit).clamp(0.0, 1.0) : 0.0,
            backgroundColor: Theme.of(context).dividerColor.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${pct.toStringAsFixed(0)}% used',
                style: Theme.of(context).textTheme.bodySmall),
            Text(
              '${CurrencyFormatter.format(remaining, currencySymbol)} left',
              style: TextStyle(
                color: isOver ? const Color(0xFFB00020) : null,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
