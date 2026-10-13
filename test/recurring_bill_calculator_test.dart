import 'package:flutter_test/flutter_test.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/domain/usecases/calculators.dart';

void main() {
  group('RecurringBillCalculator', () {
    final monthlyBill = RecurringBill(
      id: '1',
      name: 'Rent',
      amount: 500,
      categoryId: 'cat',
      dueDate: DateTime(2026, 3, 15),
      frequency: BillFrequency.monthly,
      reminderDaysBefore: 2,
    );

    final weeklyBill = RecurringBill(
      id: '2',
      name: 'Gym',
      amount: 20,
      categoryId: 'cat',
      dueDate: DateTime(2026, 3, 10),
      frequency: BillFrequency.weekly,
      reminderDaysBefore: 1,
    );

    test('calculates next monthly due date', () {
      final next = RecurringBillCalculator.nextDueDate(monthlyBill);
      expect(next.month, 4);
      expect(next.day, 15);
    });

    test('calculates next weekly due date', () {
      final next = RecurringBillCalculator.nextDueDate(weeklyBill);
      expect(next.difference(weeklyBill.dueDate).inDays, 7);
    });

    test('calculates reminder date', () {
      final reminder = RecurringBillCalculator.reminderDate(monthlyBill);
      expect(reminder.day, 13);
    });

    test('detects due soon bills', () {
      final soonBill = RecurringBill(
        id: '3',
        name: 'Netflix',
        amount: 15,
        categoryId: 'cat',
        dueDate: DateTime.now().add(const Duration(days: 3)),
        frequency: BillFrequency.monthly,
      );
      expect(RecurringBillCalculator.isDueSoon(soonBill), true);
    });
  });
}
