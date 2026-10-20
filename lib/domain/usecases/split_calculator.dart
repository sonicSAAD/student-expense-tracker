/// Pure logic for split expense calculations.
class SplitCalculator {
  static List<double> equalSplit(double total, int participants) {
    if (participants <= 0) return [];
    final perPerson = total / participants;
    return List.generate(participants, (_) => perPerson);
  }

  static bool isFullySettled(List<bool> paidStatuses) {
    return paidStatuses.isNotEmpty && paidStatuses.every((p) => p);
  }

  static double totalOwed(List<double> amounts, List<bool> paidStatuses) {
    final count =
        amounts.length < paidStatuses.length ? amounts.length : paidStatuses.length;
    double owed = 0;
    for (var i = 0; i < count; i++) {
      if (!paidStatuses[i]) owed += amounts[i];
    }
    return owed;
  }
}
