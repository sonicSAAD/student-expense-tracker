import 'package:go_router/go_router.dart';
import 'package:student_expense_tracker/presentation/features/accounts/screen/accounts_screen.dart';
import 'package:student_expense_tracker/presentation/features/analytics/screen/analytics_screen.dart';
import 'package:student_expense_tracker/presentation/features/budgets/screen/budgets_screen.dart';
import 'package:student_expense_tracker/presentation/features/home/screen/dashboard_screen.dart';
import 'package:student_expense_tracker/presentation/features/recurring_bills/screen/recurring_bills_screen.dart';
import 'package:student_expense_tracker/presentation/features/savings_goals/screen/savings_goals_screen.dart';
import 'package:student_expense_tracker/presentation/features/settings/screen/settings_screen.dart';
import 'package:student_expense_tracker/presentation/features/split_expenses/screen/split_expenses_screen.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/add_transaction_screen.dart';
import 'package:student_expense_tracker/presentation/features/transactions/screen/transactions_screen.dart';
import 'package:student_expense_tracker/presentation/router/app_routes.dart';

enum TransactionTypeArg { expense, income }

List<RouteBase> appShellRoutes() => [
      GoRoute(path: AppRoutes.home, builder: (_, __) => const DashboardScreen()),
      GoRoute(path: AppRoutes.transactions, builder: (_, __) => const TransactionsScreen()),
      GoRoute(
        path: AppRoutes.addTransaction,
        builder: (_, state) {
          final type = state.uri.queryParameters['type'];
          return AddTransactionScreen(
            initialType: type == 'income' ? TransactionTypeArg.income : TransactionTypeArg.expense,
          );
        },
      ),
      GoRoute(
        path: '${AppRoutes.editTransaction}/:id',
        builder: (_, state) => AddTransactionScreen(transactionId: state.pathParameters['id']),
      ),
      GoRoute(path: AppRoutes.accounts, builder: (_, __) => const AccountsScreen()),
      GoRoute(path: AppRoutes.budgets, builder: (_, __) => const BudgetsScreen()),
      GoRoute(path: AppRoutes.analytics, builder: (_, __) => const AnalyticsScreen()),
      GoRoute(path: AppRoutes.settings, builder: (_, __) => const SettingsScreen()),
      GoRoute(path: AppRoutes.recurringBills, builder: (_, __) => const RecurringBillsScreen()),
      GoRoute(path: AppRoutes.savingsGoals, builder: (_, __) => const SavingsGoalsScreen()),
      GoRoute(path: AppRoutes.splitExpenses, builder: (_, __) => const SplitExpensesScreen()),
    ];
