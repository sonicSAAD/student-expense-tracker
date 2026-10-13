import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/features/accounts/service/account_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_service.dart';
import 'package:student_expense_tracker/features/recurring_bills/service/recurring_bill_service.dart';

class RecurringBillPaidService {
  RecurringBillPaidService({
    required RecurringBillService bills,
    required TransactionService transactions,
    required AccountService accounts,
  })  : _bills = bills,
        _transactions = transactions,
        _accounts = accounts;

  final RecurringBillService _bills;
  final TransactionService _transactions;
  final AccountService _accounts;

  Future<void> markAsPaid(RecurringBill bill) => markPaid(bill);

  Future<void> markPaid(RecurringBill bill) async {
    final accounts = _accounts.getAll();
    final accountId = bill.accountId ?? accounts.firstOrNull?.id;
    if (accountId == null) return;

    await _transactions.add(Transaction(
      id: '${bill.id}_paid_${DateTime.now().millisecondsSinceEpoch}',
      amount: bill.amount,
      type: TransactionType.expense,
      categoryId: bill.categoryId,
      accountId: accountId,
      note: 'Recurring: ${bill.name}',
      date: DateTime.now(),
      isRecurring: true,
      recurringFrequency: bill.frequency,
    ));

    final nextDue = bill.frequency == BillFrequency.monthly
        ? DateTime(bill.dueDate.year, bill.dueDate.month + 1, bill.dueDate.day)
        : bill.dueDate.add(const Duration(days: 7));

    await _bills.update(RecurringBill(
      id: bill.id,
      name: bill.name,
      amount: bill.amount,
      categoryId: bill.categoryId,
      dueDate: nextDue,
      frequency: bill.frequency,
      reminderEnabled: bill.reminderEnabled,
      reminderDaysBefore: bill.reminderDaysBefore,
      accountId: bill.accountId,
    ));
  }
}
