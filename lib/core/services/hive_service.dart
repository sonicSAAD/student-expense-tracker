import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_expense_tracker/core/constants/app_constants.dart';
import 'package:student_expense_tracker/core/services/hive_seed_helper.dart';

class HiveService {
  HiveService._();
  static final HiveService instance = HiveService._();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    await Hive.initFlutter();
    await Future.wait([
      Hive.openBox(AppConstants.boxTransactions),
      Hive.openBox(AppConstants.boxCategories),
      Hive.openBox(AppConstants.boxAccounts),
      Hive.openBox(AppConstants.boxBudgets),
      Hive.openBox(AppConstants.boxRecurringBills),
      Hive.openBox(AppConstants.boxSavingsGoals),
      Hive.openBox(AppConstants.boxSplitExpenses),
      Hive.openBox(AppConstants.boxSettings),
    ]);
    await HiveSeedHelper.seedDefaultsIfNeeded(
      categories: _categories,
      accounts: _accounts,
      settings: _settings,
    );
    _initialized = true;
  }

  Box get _transactions => Hive.box(AppConstants.boxTransactions);
  Box get _categories => Hive.box(AppConstants.boxCategories);
  Box get _accounts => Hive.box(AppConstants.boxAccounts);
  Box get _budgets => Hive.box(AppConstants.boxBudgets);
  Box get _recurringBills => Hive.box(AppConstants.boxRecurringBills);
  Box get _savingsGoals => Hive.box(AppConstants.boxSavingsGoals);
  Box get _splitExpenses => Hive.box(AppConstants.boxSplitExpenses);
  Box get _settings => Hive.box(AppConstants.boxSettings);

  List<Map> getAllFromBox(Box box) =>
      box.values.map((e) => Map<String, dynamic>.from(e as Map)).toList();

  Future<void> putInBox(Box box, String key, Map value) => box.put(key, value);
  Future<void> deleteFromBox(Box box, String key) => box.delete(key);

  Future<void> clearAllData() async {
    await Future.wait([
      _transactions.clear(),
      _categories.clear(),
      _accounts.clear(),
      _budgets.clear(),
      _recurringBills.clear(),
      _savingsGoals.clear(),
      _splitExpenses.clear(),
      _settings.clear(),
    ]);
    await HiveSeedHelper.seedDefaultsIfNeeded(
      categories: _categories,
      accounts: _accounts,
      settings: _settings,
    );
  }

  Box transactionsBox() => _transactions;
  Box categoriesBox() => _categories;
  Box accountsBox() => _accounts;
  Box budgetsBox() => _budgets;
  Box recurringBillsBox() => _recurringBills;
  Box savingsGoalsBox() => _savingsGoals;
  Box splitExpensesBox() => _splitExpenses;
  Box settingsBox() => _settings;
}
