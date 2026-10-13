import 'package:flutter/material.dart';
import 'package:student_expense_tracker/core/utils/currency_formatter.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';

class AnalyticsCategoryList extends StatelessWidget {
  const AnalyticsCategoryList({
    super.key,
    required this.categorySpending,
    required this.categories,
    required this.currencySymbol,
  });

  final Map<String, double> categorySpending;
  final List<Category> categories;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final entries = categorySpending.entries.take(5).toList();

    return Column(
      children: entries.map((e) {
        final cat = categories.where((c) => c.id == e.key).firstOrNull;
        return ListTile(
          dense: true,
          leading: CircleAvatar(
            backgroundColor: cat != null ? Color(cat.color).withValues(alpha: 0.15) : null,
            child: Text(
              cat?.name.substring(0, 1) ?? '?',
              style: TextStyle(color: cat != null ? Color(cat.color) : Colors.grey),
            ),
          ),
          title: Text(cat?.name ?? 'Unknown'),
          trailing: Text(
            CurrencyFormatter.format(e.value, currencySymbol),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}
