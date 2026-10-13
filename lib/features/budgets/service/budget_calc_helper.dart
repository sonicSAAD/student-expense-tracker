import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

class BudgetCalcHelper {
  static String monthKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}';

  static double spentForCategory(
    List<Transaction> all,
    String categoryId,
    String month,
  ) =>
      all
          .where((t) =>
              t.type == TransactionType.expense &&
              t.categoryId == categoryId &&
              monthKey(t.date) == month)
          .fold(0.0, (sum, t) => sum + t.amount);

  static Map<String, double> spendingForMonth(
    List<Transaction> all,
    String month,
  ) {
    final map = <String, double>{};
    for (final t in all) {
      if (t.type == TransactionType.expense && monthKey(t.date) == month) {
        map[t.categoryId] = (map[t.categoryId] ?? 0) + t.amount;
      }
    }
    return map;
  }

  static double monthIncome(List<Transaction> all, DateTime month) {
    final key = monthKey(month);
    return all
        .where((t) =>
            t.type == TransactionType.income && monthKey(t.date) == key)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  static double monthExpense(List<Transaction> all, DateTime month) {
    final key = monthKey(month);
    return all
        .where((t) =>
            t.type == TransactionType.expense && monthKey(t.date) == key)
        .fold(0.0, (sum, t) => sum + t.amount);
  }
}
