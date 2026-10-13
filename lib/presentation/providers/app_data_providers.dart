import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/app_settings.dart';
import 'package:student_expense_tracker/domain/entities/category.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/domain/entities/savings_goal.dart';
import 'package:student_expense_tracker/domain/entities/split_expense.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/presentation/providers/app_feature_services.dart';

final class RefreshNotifier extends StateNotifier<int> {
  RefreshNotifier() : super(0);
  void refresh() => state++;
}

final appRefreshProvider =
    StateNotifierProvider<RefreshNotifier, int>((ref) => RefreshNotifier());

final settingsProvider = Provider<AppSettings>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).settings.get();
});

final transactionsProvider = Provider<List<Transaction>>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).transactions.getAll();
});

final categoriesProvider = Provider<List<Category>>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).categories.getAll();
});

final accountsProvider = Provider<List<Account>>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).accounts.getAll();
});

final totalBalanceProvider = Provider<double>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).accounts.getTotalBalance();
});

final recurringBillsProvider = Provider<List<RecurringBill>>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).recurringBills.getAll();
});

final savingsGoalsProvider = Provider<List<SavingsGoal>>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).savingsGoals.getAll();
});

final splitExpensesProvider = Provider<List<SplitExpense>>((ref) {
  ref.watch(appRefreshProvider);
  return ref.watch(appFeatureProvider).splitExpenses.getAll();
});
