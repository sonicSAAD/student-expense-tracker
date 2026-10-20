import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

class BudgetCalcHelper {
  static double spentForCategory(
    List<Transaction> all,
    String categoryId,
    String month,
  ) =>
      all
          .where((t) =>
              t.type == TransactionType.expense &&
              t.categoryId == categoryId &&
              AppDateUtils.monthKey(t.date) == month)
          .fold(0.0, (sum, t) => sum + t.amount);

  static Map<String, double> spendingForMonth(
    List<Transaction> all,
    String month,
  ) {
    final map = <String, double>{};
    for (final t in all) {
      if (t.type == TransactionType.expense && AppDateUtils.monthKey(t.date) == month) {
        map[t.categoryId] = (map[t.categoryId] ?? 0) + t.amount;
      }
    }
    return map;
  }

  static double monthIncome(List<Transaction> all, DateTime month) =>
      _monthTotal(all, AppDateUtils.monthKey(month), TransactionType.income);

  static double monthExpense(List<Transaction> all, DateTime month) =>
      _monthTotal(all, AppDateUtils.monthKey(month), TransactionType.expense);

  static double _monthTotal(List<Transaction> all, String key, TransactionType type) =>
      all
          .where((t) => t.type == type && AppDateUtils.monthKey(t.date) == key)
          .fold(0.0, (sum, t) => sum + t.amount);

  /// Income and expense totals for each of [months], in a single pass.
  static ({List<double> income, List<double> expense}) monthlySeries(
    List<Transaction> all,
    List<DateTime> months,
  ) {
    final index = <String, int>{
      for (var i = 0; i < months.length; i++) AppDateUtils.monthKey(months[i]): i,
    };
    final income = List<double>.filled(months.length, 0);
    final expense = List<double>.filled(months.length, 0);
    for (final t in all) {
      final i = index[AppDateUtils.monthKey(t.date)];
      if (i == null) continue;
      final bucket = t.type == TransactionType.income ? income : expense;
      bucket[i] += t.amount;
    }
    return (income: income, expense: expense);
  }
}
