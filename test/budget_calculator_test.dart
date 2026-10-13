import 'package:flutter_test/flutter_test.dart';
import 'package:student_expense_tracker/domain/usecases/calculators.dart';

void main() {
  group('BudgetCalculator', () {
    test('calculates spent percentage correctly', () {
      expect(BudgetCalculator.spentPercentage(50, 100), 50);
      expect(BudgetCalculator.spentPercentage(80, 100), 80);
      expect(BudgetCalculator.spentPercentage(0, 0), 0);
    });

    test('detects budget warning at 80%', () {
      expect(BudgetCalculator.isBudgetWarning(80, 100), true);
      expect(BudgetCalculator.isBudgetWarning(79, 100), false);
    });

    test('detects budget exceeded at 100%', () {
      expect(BudgetCalculator.isBudgetExceeded(100, 100), true);
      expect(BudgetCalculator.isBudgetExceeded(150, 100), true);
      expect(BudgetCalculator.isBudgetExceeded(99, 100), false);
    });

    test('calculates remaining budget', () {
      expect(BudgetCalculator.remainingBudget(30, 100), 70);
      expect(BudgetCalculator.remainingBudget(120, 100), -20);
    });
  });
}
