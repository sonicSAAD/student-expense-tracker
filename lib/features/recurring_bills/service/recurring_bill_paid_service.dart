import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/recurring_bill.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/domain/usecases/recurring_bill_calculator.dart';
import 'package:student_expense_tracker/features/accounts/service/account_service.dart';
import 'package:student_expense_tracker/features/recurring_bills/service/recurring_bill_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_balance_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_service.dart';

/// Records a recurring bill payment, syncs the account balance, and advances
/// the bill to its next cycle.
class RecurringBillPaidService {
  RecurringBillPaidService({
    required RecurringBillService bills,
    required TransactionService transactions,
    required AccountService accounts,
  })  : _bills = bills,
        _transactions = transactions,
        _accounts = accounts,
        _balances = TransactionBalanceService(accounts: accounts);

  final RecurringBillService _bills;
  final TransactionService _transactions;
  final AccountService _accounts;
  final TransactionBalanceService _balances;

  Future<void> markAsPaid(RecurringBill bill) => markPaid(bill);

  /// Writes the payment transaction, applies it to the account balance, then
  /// rolls the bill forward to its next due date.
  Future<void> markPaid(RecurringBill bill) async {
    final accountId = bill.accountId ?? _accounts.getAll().firstOrNull?.id;
    if (accountId == null) return;

    final transaction = Transaction(
      id: '${bill.id}_paid_${DateTime.now().millisecondsSinceEpoch}',
      amount: bill.amount,
      type: TransactionType.expense,
      categoryId: bill.categoryId,
      accountId: accountId,
      note: 'Recurring: ${bill.name}',
      date: DateTime.now(),
      isRecurring: true,
      recurringFrequency: bill.frequency,
    );
    await _transactions.add(transaction);
    await _balances.apply(transaction);

    await _bills.update(RecurringBill(
      id: bill.id,
      name: bill.name,
      amount: bill.amount,
      categoryId: bill.categoryId,
      dueDate: RecurringBillCalculator.nextDueDate(bill),
      frequency: bill.frequency,
      reminderEnabled: bill.reminderEnabled,
      reminderDaysBefore: bill.reminderDaysBefore,
      accountId: bill.accountId,
    ));
  }
}
