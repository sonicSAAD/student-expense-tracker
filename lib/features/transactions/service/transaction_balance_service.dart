import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/features/accounts/service/account_service.dart';

class TransactionBalanceService {
  TransactionBalanceService({required AccountService accounts})
      : _accounts = accounts;

  final AccountService _accounts;

  Future<void> apply(
    Transaction transaction, {
    bool isNew = true,
    bool isDelete = false,
  }) async {
    final accounts = _accounts.getAll();
    if (accounts.isEmpty) return;

    final account = accounts.firstWhere(
      (a) => a.id == transaction.accountId,
      orElse: () => accounts.first,
    );

    double delta = transaction.type == TransactionType.income
        ? transaction.amount
        : -transaction.amount;

    if (!isNew || isDelete) {
      delta = -delta;
    }

    final updated = Account(
      id: account.id,
      name: account.name,
      icon: account.icon,
      balance: account.balance + delta,
    );

    await _accounts.update(updated);
  }

  Future<void> revert(Transaction transaction) async {
    await apply(transaction, isNew: false, isDelete: true);
  }
}
