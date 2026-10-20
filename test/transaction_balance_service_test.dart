import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/domain/entities/account.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:student_expense_tracker/features/accounts/service/account_service.dart';
import 'package:student_expense_tracker/features/transactions/service/transaction_balance_service.dart';

Account _cash(double balance) =>
    Account(id: 'a1', name: 'Cash', icon: 'payments', balance: balance);

Transaction _tx(double amount, TransactionType type, {String accountId = 'a1'}) =>
    Transaction(
      id: 't1',
      amount: amount,
      type: type,
      categoryId: 'c1',
      accountId: accountId,
      date: DateTime(2026, 1, 1),
    );

void main() {
  final accounts = AccountService(hive: HiveService.instance);
  final balances = TransactionBalanceService(accounts: accounts);

  setUpAll(() async {
    Hive.init(Directory.systemTemp.createTempSync('fer_balance').path);
    await Hive.openBox('accounts');
  });

  setUp(() async {
    await Hive.box('accounts').clear();
    await accounts.add(_cash(100));
  });

  test('apply debits a new expense and revert restores it', () async {
    await balances.apply(_tx(30, TransactionType.expense));
    expect(accounts.findById('a1')!.balance, 70);

    await balances.revert(_tx(30, TransactionType.expense));
    expect(accounts.findById('a1')!.balance, 100);
  });

  test('apply credits income', () async {
    await balances.apply(_tx(40, TransactionType.income));
    expect(accounts.findById('a1')!.balance, 140);
  });

  test('editing replaces the old effect with the new one', () async {
    await balances.apply(_tx(30, TransactionType.expense));
    await balances.revert(_tx(30, TransactionType.expense));
    await balances.apply(_tx(50, TransactionType.expense));
    expect(accounts.findById('a1')!.balance, 50);
  });

  test('a missing account is ignored, not charged to another one', () async {
    await balances.apply(_tx(25, TransactionType.expense, accountId: 'gone'));
    expect(accounts.findById('a1')!.balance, 100);
  });
}
