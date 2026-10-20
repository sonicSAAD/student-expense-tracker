import 'package:flutter_test/flutter_test.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/features/budgets/service/budget_calc_helper.dart';

Transaction _tx(
  double amount,
  TransactionType type,
  DateTime date, {
  String category = 'food',
}) =>
    Transaction(
      id: '${date.microsecondsSinceEpoch}_$amount',
      amount: amount,
      type: type,
      categoryId: category,
      accountId: 'a',
      date: date,
    );

void main() {
  final txns = [
    _tx(50, TransactionType.expense, DateTime(2026, 1, 10)),
    _tx(30, TransactionType.expense, DateTime(2026, 1, 20), category: 'transport'),
    _tx(200, TransactionType.income, DateTime(2026, 1, 5)),
    _tx(40, TransactionType.expense, DateTime(2026, 2, 3)),
    _tx(10, TransactionType.expense, DateTime(2025, 12, 31)),
  ];

  test('month totals only include that month', () {
    expect(BudgetCalcHelper.monthIncome(txns, DateTime(2026, 1)), 200);
    expect(BudgetCalcHelper.monthExpense(txns, DateTime(2026, 1)), 80);
    expect(BudgetCalcHelper.monthExpense(txns, DateTime(2026, 2)), 40);
  });

  test('spendingForMonth groups expense by category', () {
    expect(
      BudgetCalcHelper.spendingForMonth(txns, '2026-01'),
      {'food': 50, 'transport': 30},
    );
  });

  test('monthlySeries matches the per-month helpers across a range', () {
    final months = [DateTime(2025, 12), DateTime(2026, 1), DateTime(2026, 2)];
    final series = BudgetCalcHelper.monthlySeries(txns, months);
    expect(series.expense, [10, 80, 40]);
    expect(series.income, [0, 200, 0]);
  });
}
