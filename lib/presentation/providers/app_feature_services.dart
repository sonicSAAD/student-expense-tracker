import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/core/services/notification_service.dart';
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
import 'package:student_expense_tracker/presentation/providers/app_feature_services_model.dart';

final hiveServiceProvider =
    Provider<HiveService>((ref) => HiveService.instance);

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService.instance,
);

final appFeatureProvider = Provider((ref) {
  final hive = ref.watch(hiveServiceProvider);
  final notifs = ref.watch(notificationServiceProvider);
  final cats = CategoryService(hive: hive);
  final accs = AccountService(hive: hive);
  final txs = TransactionService(hive: hive);
  final bgs = BudgetService(hive: hive, transactions: txs);
  final sets = SettingsService(hive: hive);
  final bills = RecurringBillService(hive: hive, notifications: notifs);
  final goals = SavingsGoalService(hive: hive);
  final splits = SplitExpenseService(hive: hive);
  return AppFeatureServices(
    categories: cats,
    accounts: accs,
    transactions: txs,
    budgets: bgs,
    settings: sets,
    recurringBills: bills,
    savingsGoals: goals,
    splitExpenses: splits,
    backup: BackupService(hive: hive),
    transfer: TransferService(accounts: accs, transactions: txs, categories: cats),
    transactionBalance: TransactionBalanceService(accounts: accs),
    budgetRecheck: BudgetRecheckService(budgets: bgs, categories: cats),
    recurringBillPaid: RecurringBillPaidService(
      bills: bills,
      transactions: txs,
      accounts: accs,
    ),
  );
});
