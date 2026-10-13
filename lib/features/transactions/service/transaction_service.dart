import 'package:student_expense_tracker/core/services/hive_service.dart';
import 'package:student_expense_tracker/data/mappers/entity_mappers.dart';
import 'package:student_expense_tracker/domain/entities/transaction.dart';
import 'package:uuid/uuid.dart';

class TransactionService {
  TransactionService({required HiveService hive, Uuid? uuid})
      : _hive = hive;

  final HiveService _hive;

  List<Transaction> getAll() {
    try {
      return _hive
          .getAllFromBox(_hive.transactionsBox())
          .map(EntityMappers.transactionFromMap)
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));
    } catch (_) {
      return [];
    }
  }

  List<Transaction> getPage(int page, int pageSize) {
    final all = getAll();
    final start = page * pageSize;
    if (start >= all.length) return [];
    final end = start + pageSize;
    return all.sublist(start, end > all.length ? all.length : end);
  }

  Future<void> add(Transaction transaction) async {
    try {
      await _hive.putInBox(
        _hive.transactionsBox(),
        transaction.id,
        EntityMappers.transactionToMap(transaction),
      );
    } catch (_) {}
  }

  Future<void> update(Transaction oldTx, Transaction newTx) async {
    try {
      await _hive.putInBox(
        _hive.transactionsBox(),
        newTx.id,
        EntityMappers.transactionToMap(newTx),
      );
    } catch (_) {}
  }

  Future<void> delete(String id) async {
    try {
      await _hive.deleteFromBox(_hive.transactionsBox(), id);
    } catch (_) {}
  }

  Transaction? findById(String id) {
    try {
      final map = _hive.transactionsBox().get(id);
      if (map == null) return null;
      return EntityMappers.transactionFromMap(
        Map<String, dynamic>.from(map as Map),
      );
    } catch (_) {
      return null;
    }
  }
}
