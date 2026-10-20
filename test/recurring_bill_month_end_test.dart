import 'package:flutter_test/flutter_test.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/domain/usecases/calculators.dart';

RecurringBill _monthlyDue(DateTime dueDate) => RecurringBill(
      id: '1',
      name: 'Rent',
      amount: 500,
      categoryId: 'cat',
      dueDate: dueDate,
      frequency: BillFrequency.monthly,
    );

void main() {
  group('RecurringBillCalculator month-end handling', () {
    test('clamps Jan 31 to the last day of February', () {
      final next =
          RecurringBillCalculator.nextDueDate(_monthlyDue(DateTime(2026, 1, 31)));
      expect(next.month, 2);
      expect(next.day, 28);
    });

    test('rolls December into January of the next year', () {
      final next =
          RecurringBillCalculator.nextDueDate(_monthlyDue(DateTime(2026, 12, 15)));
      expect(next.year, 2027);
      expect(next.month, 1);
      expect(next.day, 15);
    });

    test('keeps a mid-month day unchanged', () {
      final next =
          RecurringBillCalculator.nextDueDate(_monthlyDue(DateTime(2026, 3, 15)));
      expect(next.month, 4);
      expect(next.day, 15);
    });
  });
}
