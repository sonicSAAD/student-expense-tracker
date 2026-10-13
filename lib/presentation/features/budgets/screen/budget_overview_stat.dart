import 'package:flutter/material.dart';

class BudgetOverviewStat extends StatelessWidget {
  const BudgetOverviewStat({
    super.key,
    required this.label,
    required this.value,
    required this.symbol,
    required this.color,
  });

  final String label;
  final double value;
  final String symbol;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 8),
        Text(
          '$symbol${value.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
