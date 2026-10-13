import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/features/accounts/service/account_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_service.dart';
import 'package:uuid/uuid.dart';

class TransferService {
  TransferService({
    required AccountService accounts,
    required TransactionService transactions,
    Uuid? uuid,
  })  : _accounts = accounts,
        _transactions = transactions,
        _uuid = uuid ?? const Uuid();

  final AccountService _accounts;
  final TransactionService _transactions;
  final Uuid _uuid;

  Future<void> transfer({
    required String fromId,
    required String toId,
    required double amount,
  }) async {
    if (fromId == toId || amount <= 0) return;

    final from = _accounts.findById(fromId);
    final to = _accounts.findById(toId);
    if (from == null || to == null) return;

    final fromCat = _accounts.getAll().firstOrNull;
    if (fromCat == null) return;

    await _accounts.update(Account(
      id: from.id,
      name: from.name,
      icon: from.icon,
      balance: from.balance - amount,
    ));
    await _accounts.update(Account(
      id: to.id,
      name: to.name,
      icon: to.icon,
      balance: to.balance + amount,
    ));

    final now = DateTime.now();
    await _transactions.add(Transaction(
      id: _uuid.v4(),
      amount: amount,
      type: TransactionType.expense,
      categoryId: fromCat.id,
      accountId: fromId,
      note: 'Transfer to ${to.name}',
      date: now,
    ));
    await _transactions.add(Transaction(
      id: _uuid.v4(),
      amount: amount,
      type: TransactionType.income,
      categoryId: fromCat.id,
      accountId: toId,
      note: 'Transfer from ${from.name}',
      date: now,
    ));
  }
}
