import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';

class AnalyticsCategoryChart extends StatelessWidget {
  const AnalyticsCategoryChart({
    super.key,
    required this.categorySpending,
    required this.categories,
    required this.totalSpent,
  });

  final Map<String, double> categorySpending;
  final List<Category> categories;
  final double totalSpent;

  @override
  Widget build(BuildContext context) {
    if (totalSpent <= 0) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: Text('No spending data for this month yet.')),
        ),
      );
    }

    final topEntries = categorySpending.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 36,
              sections: topEntries.take(5).map((e) {
                final cat = categories.where((c) => c.id == e.key).firstOrNull;
                final pct = (e.value / totalSpent * 100).round();
                return PieChartSectionData(
                  value: e.value,
                  title: '$pct%',
                  color: cat != null ? Color(cat.color) : Colors.grey,
                  radius: 50,
                  titleStyle: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
