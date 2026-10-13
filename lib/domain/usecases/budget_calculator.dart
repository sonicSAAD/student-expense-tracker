/// Pure logic for budget calculations.
class BudgetCalculator {
  static double spentPercentage(double spent, double limit) {
    if (limit <= 0) return 0;
    return (spent / limit) * 100;
  }

  static bool isBudgetWarning(double spent, double limit) {
    return spentPercentage(spent, limit) >= 80;
  }

  static bool isBudgetExceeded(double spent, double limit) {
    return spentPercentage(spent, limit) >= 100;
  }

  static double remainingBudget(double spent, double limit) {
    return limit - spent;
  }
}
