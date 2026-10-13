import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/features/budgets/service/budget_service.dart';
import 'package:student_expense_tracker/features/categories/service/category_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_service.dart';

class BudgetRecheckService {
  BudgetRecheckService({
    TransactionService? transactions,
    required BudgetService budgets,
    required CategoryService categories,
  })  : _budgets = budgets,
        _categories = categories;

  final BudgetService _budgets;
  final CategoryService _categories;

  Future<void> recheckAfterTransaction(Transaction transaction) async {
    if (transaction.type != TransactionType.expense) return;
    final month = _monthKey(transaction.date);
    await _updateSpent(transaction.categoryId, month);
  }

  Future<void> recheckAll() async {
    try {
      final budgets = _budgets.getForMonth(_currentMonth());
      for (final budget in budgets) {
        await _updateSpent(budget.categoryId, budget.month);
      }
    } catch (_) {}
  }

  Future<void> _updateSpent(String categoryId, String month) async {
    final cat = _categories.findById(categoryId);
    final limit = cat?.monthlyBudgetLimit ?? 0;
    if (limit <= 0) return;
    await _budgets.setLimit(categoryId, month, limit);
  }

  String _monthKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}';
  }

  String _currentMonth() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}';
  }
}
