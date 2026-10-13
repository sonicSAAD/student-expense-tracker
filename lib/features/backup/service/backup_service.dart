import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_expense_tracker/core/constants/app_constants.dart';
import 'package:student_expense_tracker/core/services/hive_service.dart';

class BackupService {
  BackupService({required HiveService hive}) : _hive = hive;
  final HiveService _hive;

  Future<Map<String, dynamic>> exportAll() async {
    try {
      return {
        'version': 1,
        'exportedAt': DateTime.now().toIso8601String(),
        AppConstants.boxTransactions:
            _hive.getAllFromBox(_hive.transactionsBox()),
        AppConstants.boxCategories: _hive.getAllFromBox(_hive.categoriesBox()),
        AppConstants.boxAccounts: _hive.getAllFromBox(_hive.accountsBox()),
        AppConstants.boxBudgets: _hive.getAllFromBox(_hive.budgetsBox()),
        AppConstants.boxRecurringBills:
            _hive.getAllFromBox(_hive.recurringBillsBox()),
        AppConstants.boxSavingsGoals:
            _hive.getAllFromBox(_hive.savingsGoalsBox()),
        AppConstants.boxSplitExpenses:
            _hive.getAllFromBox(_hive.splitExpensesBox()),
        AppConstants.boxSettings: _hive.settingsBox().get('app'),
      };
    } catch (_) {
      return {'version': 1, 'error': 'export_failed'};
    }
  }

  Future<void> importData(Map<String, dynamic> data) async {
    final settings = data[AppConstants.boxSettings];
    if (settings != null) {
      try {
        await _hive.settingsBox().put('app', Map<String, dynamic>.from(settings as Map));
      } catch (_) {}
    }
  }

  Future<void> shareBackup() async {
    try {
      final data = await exportAll();
      final jsonStr = const JsonEncoder.withIndent('  ').convert(data);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/expense_tracker_backup.json');
      await file.writeAsString(jsonStr);
      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], text: 'Backup'));
    } catch (_) {}
  }
}
