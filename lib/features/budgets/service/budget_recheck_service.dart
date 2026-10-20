import 'package:student_expense_tracker/core/utils/date_utils.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/features/budgets/service/budget_service.dart';
import 'package:student_expense_tracker/features/categories/service/category_service.dart';

/// Recalculates stored budget spend after the ledger changes.
class BudgetRecheckService {
  BudgetRecheckService({
    required BudgetService budgets,
    required CategoryService categories,
  })  : _budgets = budgets,
        _categories = categories;

  final BudgetService _budgets;
  final CategoryService _categories;

  Future<void> recheckAfterTransaction(Transaction transaction) async {
    if (transaction.type != TransactionType.expense) return;
    await _updateSpent(
      transaction.categoryId,
      AppDateUtils.monthKey(transaction.date),
    );
  }

  /// Recomputes every budget for the current month in a single spending pass.
  Future<void> recheckAll() async {
    try {
      final month = AppDateUtils.monthKey(DateTime.now());
      final spending = _budgets.spendingForMonth(month);
      for (final budget in _budgets.getForMonth(month)) {
        final limit = _limitFor(budget.categoryId);
        if (limit <= 0) continue;
        await _budgets.setLimit(
          budget.categoryId,
          month,
          limit,
          spent: spending[budget.categoryId] ?? 0,
        );
      }
    } catch (_) {}
  }

  Future<void> _updateSpent(String categoryId, String month) async {
    final limit = _limitFor(categoryId);
    if (limit <= 0) return;
    await _budgets.setLimit(categoryId, month, limit);
  }

  double _limitFor(String categoryId) =>
      _categories.findById(categoryId)?.monthlyBudgetLimit ?? 0;
}
