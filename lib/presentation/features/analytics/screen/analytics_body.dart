import 'package:flutter/material.dart';
import 'package:student_expense_tracker/domain/entities/app_settings.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/presentation/features/analytics/screen/analytics_bar_chart.dart';
import 'package:student_expense_tracker/presentation/features/analytics/screen/analytics_category_chart.dart';
import 'package:student_expense_tracker/presentation/features/analytics/screen/analytics_category_list.dart';

class AnalyticsBody extends StatelessWidget {
  const AnalyticsBody({
    super.key,
    required this.settings,
    required this.categories,
    required this.categorySpending,
    required this.monthlyExpenses,
    required this.monthlyIncome,
  });

  final AppSettings settings;
  final List<Category> categories;
  final Map<String, double> categorySpending;
  final List<double> monthlyExpenses;
  final List<double> monthlyIncome;

  @override
  Widget build(BuildContext context) {
    final totalSpent = categorySpending.values.fold(0.0, (sum, v) => sum + v);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Spending by Category', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          AnalyticsCategoryChart(
            categorySpending: categorySpending,
            categories: categories,
            totalSpent: totalSpent,
          ),
          const SizedBox(height: 16),
          AnalyticsCategoryList(
            categorySpending: categorySpending,
            categories: categories,
            currencySymbol: settings.currencySymbol,
          ),
          const SizedBox(height: 24),
          Text('Income vs Expenses', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          AnalyticsBarChart(
            monthlyExpenses: monthlyExpenses,
            monthlyIncome: monthlyIncome,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
