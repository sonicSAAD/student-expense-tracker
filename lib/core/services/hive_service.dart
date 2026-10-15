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
    await Future.wait(AppConstants.boxNames.map((name) => Hive.openBox(name)));
    await _seedDefaults();
    _initialized = true;
  }

  Future<void> clearAllData() async {
    await Future.wait(
      AppConstants.boxNames.map((name) => Hive.box(name).clear()),
    );
    await _seedDefaults();
  }

  Future<void> _seedDefaults() => HiveSeedHelper.seedDefaultsIfNeeded(
        categories: categoriesBox(),
        accounts: accountsBox(),
        settings: settingsBox(),
      );

  List<Map> getAllFromBox(Box box) =>
      box.values.map((e) => Map<String, dynamic>.from(e as Map)).toList();

  Future<void> putInBox(Box box, String key, Map value) => box.put(key, value);

  Future<void> deleteFromBox(Box box, String key) => box.delete(key);

  Box transactionsBox() => Hive.box(AppConstants.boxTransactions);
  Box categoriesBox() => Hive.box(AppConstants.boxCategories);
  Box accountsBox() => Hive.box(AppConstants.boxAccounts);
  Box budgetsBox() => Hive.box(AppConstants.boxBudgets);
  Box recurringBillsBox() => Hive.box(AppConstants.boxRecurringBills);
  Box savingsGoalsBox() => Hive.box(AppConstants.boxSavingsGoals);
  Box splitExpensesBox() => Hive.box(AppConstants.boxSplitExpenses);
  Box settingsBox() => Hive.box(AppConstants.boxSettings);
}
