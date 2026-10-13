import 'package:student_expense_tracker/features/accounts/service/account_service.dart';
import 'package:student_expense_tracker/features/accounts/service/transfer_service.dart';
import 'package:student_expense_tracker/features/backup/service/backup_service.dart';
import 'package:student_expense_tracker/features/budgets/service/budget_recheck_service.dart';
import 'package:student_expense_tracker/features/budgets/service/budget_service.dart';
import 'package:student_expense_tracker/features/categories/service/category_service.dart';
import 'package:student_expense_tracker/features/recurring_bills/service/recurring_bill_paid_service.dart';
import 'package:student_expense_tracker/features/recurring_bills/service/recurring_bill_service.dart';
import 'package:student_expense_tracker/features/savings_goals/service/savings_goal_service.dart';
import 'package:student_expense_tracker/features/settings/service/settings_service.dart';
import 'package:student_expense_tracker/features/split_expenses/service/split_expense_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_balance_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_service.dart';

class AppFeatureServices {
  AppFeatureServices({
    required this.categories,
    required this.accounts,
    required this.transactions,
    required this.budgets,
    required this.settings,
    required this.recurringBills,
    required this.savingsGoals,
    required this.splitExpenses,
    required this.backup,
    required this.transfer,
    required this.transactionBalance,
    required this.budgetRecheck,
    required this.recurringBillPaid,
  });

  final CategoryService categories;
  final AccountService accounts;
  final TransactionService transactions;
  final BudgetService budgets;
  final SettingsService settings;
  final RecurringBillService recurringBills;
  final SavingsGoalService savingsGoals;
  final SplitExpenseService splitExpenses;
  final BackupService backup;
  final TransferService transfer;
  final TransactionBalanceService transactionBalance;
  final BudgetRecheckService budgetRecheck;
  final RecurringBillPaidService recurringBillPaid;

  String displayBalance(double amount) => amount.toStringAsFixed(2);
}
