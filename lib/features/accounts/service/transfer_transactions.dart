import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';

/// Builds the two ledger entries (expense out, income in) that make up a
/// transfer between two accounts.
List<Transaction> buildTransferTransactions({
  required double amount,
  required String categoryId,
  required String fromAccountId,
  required String toAccountId,
  required String fromName,
  required String toName,
  required DateTime date,
  required String expenseId,
  required String incomeId,
}) {
  return [
    Transaction(
      id: expenseId,
      amount: amount,
      type: TransactionType.expense,
      categoryId: categoryId,
      accountId: fromAccountId,
      note: 'Transfer to $toName',
      date: date,
    ),
    Transaction(
      id: incomeId,
      amount: amount,
      type: TransactionType.income,
      categoryId: categoryId,
      accountId: toAccountId,
      note: 'Transfer from $fromName',
      date: date,
    ),
  ];
}
