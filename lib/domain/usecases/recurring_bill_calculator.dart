import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';

/// Pure logic for recurring bill calculations.
class RecurringBillCalculator {
  static DateTime nextDueDate(RecurringBill bill) {
    if (bill.frequency == BillFrequency.monthly) {
      return DateTime(
        bill.dueDate.year,
        bill.dueDate.month + 1,
        bill.dueDate.day,
      );
    }
    return bill.dueDate.add(const Duration(days: 7));
  }

  static DateTime reminderDate(RecurringBill bill) {
    return bill.dueDate.subtract(Duration(days: bill.reminderDaysBefore));
  }

  static bool isDueSoon(RecurringBill bill, {int days = 7}) {
    final now = DateTime.now();
    final diff = bill.dueDate.difference(now).inDays;
    return diff >= 0 && diff <= days;
  }

  static bool isOverdue(RecurringBill bill) {
    return bill.dueDate.isBefore(DateTime.now());
  }

  static List<RecurringBill> upcomingBills(
    List<RecurringBill> bills,
    int count,
  ) {
    final sorted = List<RecurringBill>.from(bills)
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return sorted.take(count).toList();
  }
}
