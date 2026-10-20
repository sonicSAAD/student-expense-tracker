import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/features/accounts/service/account_service.dart';

/// Keeps account balances in sync with the transaction ledger.
///
/// Each public method performs exactly one adjustment, so callers compose
/// add / edit / delete flows (revert then apply) without the balance drifting.
class TransactionBalanceService {
  TransactionBalanceService({required AccountService accounts})
      : _accounts = accounts;

  final AccountService _accounts;

  /// Adds the signed effect of [transaction] to its account balance.
  Future<void> apply(Transaction transaction) =>
      _adjust(transaction, multiplier: 1);

  /// Removes the signed effect of [transaction] from its account balance.
  Future<void> revert(Transaction transaction) =>
      _adjust(transaction, multiplier: -1);

  Future<void> _adjust(
    Transaction transaction, {
    required int multiplier,
  }) async {
    final account = _accounts.findById(transaction.accountId);
    // The account is gone (deleted): there is nothing to adjust.
    if (account == null) return;

    final delta = transaction.type == TransactionType.income
        ? transaction.amount
        : -transaction.amount;

    await _accounts.update(Account(
      id: account.id,
      name: account.name,
      icon: account.icon,
      balance: account.balance + delta * multiplier,
    ));
  }
}
