import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/features/accounts/service/account_service.dart';
import 'package:student_expense_tracker/features/accounts/service/transfer_transactions.dart';
import 'package:student_expense_tracker/features/categories/service/category_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_service.dart';
import 'package:uuid/uuid.dart';

class TransferService {
  TransferService({
    required AccountService accounts,
    required TransactionService transactions,
    required CategoryService categories,
    Uuid? uuid,
  })  : _accounts = accounts,
        _transactions = transactions,
        _categories = categories,
        _uuid = uuid ?? const Uuid();

  final AccountService _accounts;
  final TransactionService _transactions;
  final CategoryService _categories;
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

    final category = transferCategory(_categories.getAll());
    if (category == null) return;

    await _applyDelta(from, -amount);
    await _applyDelta(to, amount);

    final entries = buildTransferTransactions(
      amount: amount,
      categoryId: category.id,
      fromAccountId: from.id,
      toAccountId: to.id,
      fromName: from.name,
      toName: to.name,
      date: DateTime.now(),
      expenseId: _uuid.v4(),
      incomeId: _uuid.v4(),
    );
    for (final entry in entries) {
      await _transactions.add(entry);
    }
  }

  Future<void> _applyDelta(Account account, double delta) => _accounts.update(
        Account(
          id: account.id,
          name: account.name,
          icon: account.icon,
          balance: account.balance + delta,
        ),
      );
}
