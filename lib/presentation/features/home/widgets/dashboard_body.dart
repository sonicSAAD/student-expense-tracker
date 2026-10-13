import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/domain/entities/app_settings.dart';
import 'package:student_expense_tracker/domain/entities/budget.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/presentation/features/home/widgets/dashboard_balance_card.dart';
import 'package:student_expense_tracker/presentation/features/home/widgets/dashboard_bills_section.dart';
import 'package:student_expense_tracker/presentation/features/home/widgets/dashboard_budget_section.dart';
import 'package:student_expense_tracker/presentation/features/home/widgets/dashboard_recent_transactions.dart';
import 'package:student_expense_tracker/presentation/features/home/widgets/dashboard_summary_card.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

class DashboardBody extends ConsumerWidget {
  const DashboardBody({
    super.key, required this.settings, required this.totalBalance,
    required this.income, required this.expense, required this.transactions,
    required this.categories, required this.budgets, required this.bills,
    required this.categorySpending,
  });

  final AppSettings settings;
  final double totalBalance;
  final double income;
  final double expense;
  final List<Transaction> transactions;
  final List<Category> categories;
  final List<Budget> budgets;
  final List<RecurringBill> bills;
  final Map<String, double> categorySpending;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async => ref.read(appRefreshProvider.notifier).refresh(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DashboardBalanceCard(balance: totalBalance, symbol: settings.currencySymbol),
          const SizedBox(height: 16),
          DashboardSummaryCard(income: income, expense: expense, symbol: settings.currencySymbol),
          const SizedBox(height: 24),
          DashboardBudgetSection(
            budgets: budgets,
            categories: categories,
            categorySpending: categorySpending,
            symbol: settings.currencySymbol,
          ),
          const SizedBox(height: 24),
          DashboardBillsSection(bills: bills, symbol: settings.currencySymbol),
          const SizedBox(height: 24),
          DashboardRecentTransactions(
            transactions: transactions,
            categories: categories,
            symbol: settings.currencySymbol,
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
