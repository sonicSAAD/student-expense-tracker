import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/budget.dart';
import 'package:student_expense_tracker/features/budgets/service/budget_calc_helper.dart';
import 'package:student_expense_tracker/features/categories/service/category_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_service.dart';

class BudgetService {
  BudgetService({
    required HiveService hive,
    required TransactionService transactions,
    required CategoryService categories,
  })  : _hive = hive,
        _transactions = transactions;

  final HiveService _hive;
  final TransactionService _transactions;

  List<Budget> getForMonth(String month) {
    try {
      return _hive
          .getAllFromBox(_hive.budgetsBox())
          .map(EntityMappers.budgetFromMap)
          .where((b) => b.month == month)
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> setLimit(String categoryId, String month, double limit) async {
    try {
      final spent = spentForCategory(categoryId, month);
      await _hive.putInBox(
        _hive.budgetsBox(),
        '${categoryId}_$month',
        EntityMappers.budgetToMap(Budget(
          categoryId: categoryId,
          month: month,
          limitAmount: limit,
          spentAmount: spent,
        )),
      );
    } catch (_) {}
  }

  double spentForCategory(String categoryId, String month) =>
      BudgetCalcHelper.spentForCategory(
          _transactions.getAll(), categoryId, month);

  Map<String, double> spendingForMonth(String month) =>
      BudgetCalcHelper.spendingForMonth(_transactions.getAll(), month);

  double monthIncome(DateTime month) =>
      BudgetCalcHelper.monthIncome(_transactions.getAll(), month);

  double monthExpense(DateTime month) =>
      BudgetCalcHelper.monthExpense(_transactions.getAll(), month);
}
