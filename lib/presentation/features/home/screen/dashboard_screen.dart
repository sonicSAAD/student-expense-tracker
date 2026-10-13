import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/presentation/features/home/widgets/dashboard_body.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_balance_wallet_outlined),
            onPressed: () => context.push(AppRoutes.accounts),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'add_income',
            onPressed: () => context.push('${AppRoutes.addTransaction}?type=income'),
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.extended(
            heroTag: 'add_expense',
            onPressed: () => context.push(AppRoutes.addTransaction),
            icon: const Icon(Icons.remove),
            label: const Text('Expense'),
          ),
        ],
      ),
      body: DashboardBody(
        settings: ref.watch(settingsProvider),
        totalBalance: ref.watch(totalBalanceProvider),
        income: ref.watch(monthIncomeProvider),
        expense: ref.watch(monthExpenseProvider),
        transactions: ref.watch(transactionsProvider),
        categories: ref.watch(categoriesProvider),
        budgets: ref.watch(currentMonthBudgetsProvider),
        bills: ref.watch(recurringBillsProvider),
        categorySpending: ref.watch(categorySpendingProvider),
      ),
    );
  }
}
