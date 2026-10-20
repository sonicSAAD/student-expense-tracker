import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/presentation/features/analytics/screen/analytics_body.dart';
import 'package:student_expense_tracker/presentation/features/analytics/screen/analytics_exporter.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final categories = ref.watch(categoriesProvider);
    final transactions = ref.watch(transactionsProvider);
    final spending = ref.watch(categorySpendingProvider);
    final series = ref.watch(monthlySeriesProvider);

    final totalSpent = spending.values.fold(0.0, (s, v) => s + v);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined),
            onPressed: () => AnalyticsExporter.exportCsv(
              transactions: transactions,
              categories: categories,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () => AnalyticsExporter.exportPdf(
              currencySymbol: settings.currencySymbol,
              totalSpent: totalSpent,
              categorySpending: spending,
              categories: categories,
            ),
          ),
        ],
      ),
      body: AnalyticsBody(
        settings: settings,
        categories: categories,
        categorySpending: spending,
        monthlyExpenses: series.expense,
        monthlyIncome: series.income,
      ),
    );
  }
}
